import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:team_manager/openapi/api.dart';
import 'package:team_manager/page/planning/planning_conges.dart';
import 'package:team_manager/service/date_utils_service.dart';
import 'package:team_manager/service/user_connected_service.dart';

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class CongesDataSource extends CalendarDataSource {
  late int userConnectedId;
  late CongesControllerApi congesControllerApi;

  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  CongesDataSource(PageTeammateDto? dto) : super() {
    final UserConnectedService userConnectedService = GetIt.I.get();
    congesControllerApi = GetIt.I.get();
    userConnectedId = userConnectedService.user!.id!;
    appointments = [];
    _setResources(dto);
    _fetch();
  }

  @override
  DateTime getStartTime(int index) {
    return _getCongesData(index)!.dateDebut;
  }

  @override
  DateTime getEndTime(int index) {
    return _getCongesData(index)!.dateFin;
  }

  @override
  String getSubject(int index) {
    return _getCongesData(index)!.typeConges.toString();
  }

  @override
  Color getColor(int index) {
    switch (_getCongesData(index)!.typeConges) {
      case CongesCreateDtoTypeCongesEnum.CONGE_PAYE:
        return const Color(0xFFA621F3);
      case CongesCreateDtoTypeCongesEnum.MALADIE:
        return const Color(0xFF67F321);
      case CongesCreateDtoTypeCongesEnum.SANS_SOLDE:
        return const Color(0xFFF32159);
      default:
        return const Color(0xFF2196F3);
    }
  }

  @override
  bool isAllDay(int index) {
    final DateTime dateDebut = _getCongesData(index)!.dateDebut;
    final DateTime dateFin = _getCongesData(index)!.dateFin;
    final Duration diff = dateFin.difference(dateDebut);
    return diff.inHours >= 8;
  }

  @override
  List<Object> getResourceIds(int index) {
    return _getCongesData(index)!.resources;
  }

  Future<CongesDto?> saveConges(Conges conges) {
    if (appointments!.any((element) => element.id == conges.id)) {
      return _updateConges(conges);
    } else {
      return _createConges(conges);
    }
  }

  deleteById(int id) {
    congesControllerApi.delete3(id).then((_) {
      final int index = appointments!.indexWhere((element) => element.id == id);
      final Conges congesToDelete = appointments![index];
      appointments!.removeWhere((element) => element.id == id);
      notifyListeners(CalendarDataSourceAction.remove, [congesToDelete]);
    });
  }

  _setResources(PageTeammateDto? pageTeammateDto) {
    resources = [];

    if (pageTeammateDto != null) {
      resources!.addAll(
        pageTeammateDto.content.map((e) => CalendarResource(
            id: e.email!,
            displayName: e.prenom!,
            image: (e.photo != null) ? MemoryImage(base64Decode(e.photo!)) : null)),
      );
    }
  }

  /// Va récupérer les datas depuis le back pour alimenter la datasource.
  _fetch() {
    appointments = [];
    notifyListeners(CalendarDataSourceAction.reset, []);

    congesControllerApi.getAll2(Pageable()).then((pageCongesDto) {
      if (pageCongesDto?.content == null) return;
      pageCongesDto!.content.map(_mapConges).forEach(_addCongesToAppointments);
    });
  }

  Conges _mapConges(CongesDto dto) {
    Conges conges = Conges(
      id: dto.id,
      dateDebut: DateUtilsService.convertDate(dto.dateDebut!),
      dateFin: DateUtilsService.convertDate(dto.dateFin!),
      typeConges: _mapTypeConges(dto),
      commentaire: dto.commentaire,
      resources: [dto.teammate!.email!],
    );
    print(conges.toString());
    return conges;
  }

  CongesCreateDtoTypeCongesEnum _mapTypeConges(CongesDto dto) {
    CongesCreateDtoTypeCongesEnum type;
    switch (dto.typeConges!) {
      case CongesDtoTypeCongesEnum.CONGE_PAYE:
        type = CongesCreateDtoTypeCongesEnum.CONGE_PAYE;
        break;
      case CongesDtoTypeCongesEnum.MALADIE:
        type = CongesCreateDtoTypeCongesEnum.MALADIE;
        break;
      case CongesDtoTypeCongesEnum.SANS_SOLDE:
        type = CongesCreateDtoTypeCongesEnum.SANS_SOLDE;
        break;
      default:
        type = CongesCreateDtoTypeCongesEnum.CONGE_PAYE;
    }
    return type;
  }

  Future<CongesDto?> _createConges(Conges conges) {
    final CongesCreateDto dto = _mapCongesToCreateDto(conges);
    return congesControllerApi.create2(dto).then((congesDto) {
      _addCongesToAppointments(_mapConges(congesDto!));
      return congesDto;
    });
  }

  Future<CongesDto?> _updateConges(Conges conges) {
    final CongesCreateDto dto = _mapCongesToCreateDto(conges);
    return congesControllerApi.update2(dto).then((congesDto) {
      _removeCongesFromAppointments(conges);
      _addCongesToAppointments(_mapConges(congesDto!));
      return congesDto;
    });
  }

  void _removeCongesFromAppointments(Conges conges) {
    final int index = appointments!.indexWhere((element) => element.id == conges.id);
    final congesRead = appointments![index];
    notifyListeners(CalendarDataSourceAction.remove, [congesRead]);
    appointments?.removeAt(index);
  }

  void _addCongesToAppointments(Conges conges) {
    appointments?.add(conges);
    notifyListeners(CalendarDataSourceAction.add, [conges]);
  }

  CongesCreateDto _mapCongesToCreateDto(Conges conges) => CongesCreateDto(
      teammateId: userConnectedId,
      dateDebut: conges.dateDebut,
      dateFin: conges.dateFin,
      typeConges: conges.typeConges!,
      commentaire: conges.commentaire);

  Conges? _getCongesData(int index) {
    if (index < 0) {
      return null;
    }

    final dynamic conges = appointments![index];
    if (conges is Conges) {
      return conges;
    }
    return null;
  }
}
