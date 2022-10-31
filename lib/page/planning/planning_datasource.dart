import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:team_manager/openapi/api.dart';
import 'package:team_manager/page/planning/planning_conges.dart';

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class CongesDataSource extends CalendarDataSource {
  late CongesControllerApi congesControllerApi;
  final portionDebutCreateTr = CongesPersistDtoPortionDebutEnumTypeTransformer();
  final portionFinCreateTr = CongesPersistDtoPortionFinEnumTypeTransformer();
  final portionDebutTr = CongesDtoPortionDebutEnumTypeTransformer();
  final portionFinTr = CongesDtoPortionFinEnumTypeTransformer();
  final dateFormat = DateFormat('dd-MM-yyyy HH:mm:ss');

  List<TeammateDto>? listTeammateDto;

  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  CongesDataSource() : super() {
    congesControllerApi = GetIt.I.get();
  }

  setPage(PageTeammateDto? pageResourcesDto) {
    appointments = [];
    _setResources(pageResourcesDto);
    _fetchConges();
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
      case CongesPersistDtoTypeCongesEnum.CONGE_PAYE:
        return const Color(0xFFA621F3);
      case CongesPersistDtoTypeCongesEnum.MALADIE:
        return const Color(0xFF67F321);
      case CongesPersistDtoTypeCongesEnum.SANS_SOLDE:
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

  Future<void> saveConges(Conges conges) {
    if (appointments!.any((element) => element.id == conges.id)) {
      return _updateConges(conges);
    } else {
      return _createConges(conges);
    }
  }

  Future<void> deleteById(int id) {
    return congesControllerApi.delete3(id).then((_) {
      final int index = appointments!.indexWhere((element) => element.id == id);
      final Conges congesToDelete = appointments![index];
      appointments!.removeWhere((element) => element.id == id);
      notifyListeners(CalendarDataSourceAction.remove, [congesToDelete]);
    });
  }

  _setResources(PageTeammateDto? pageTeammateDto) {
    resources = [];
    listTeammateDto = [];

    if (pageTeammateDto != null) {
      listTeammateDto = pageTeammateDto.content;
      resources!.addAll(
        pageTeammateDto.content.map((e) => CalendarResource(
            id: e.email!,
            displayName: e.prenom!,
            image: (e.photo != null) ? MemoryImage(base64Decode(e.photo!)) : null)),
      );
    }
  }

  /// Va récupérer les datas depuis le back pour alimenter la datasource.
  _fetchConges() {
    appointments = [];
    notifyListeners(CalendarDataSourceAction.reset, []);

    congesControllerApi.getAll2(Pageable()).then((pageCongesDto) {
      if (pageCongesDto?.content == null) return;
      pageCongesDto!.content.map(_mapConges).forEach(_addCongesToAppointments);
    });
  }

  Conges _mapConges(CongesDto dto) {
    print('_mapConges $dto');
    return Conges(
      id: dto.id,
      dateDebut: dateFormat.parse(dto.dateDebut!, false),
      dateFin: dateFormat.parse(dto.dateFin!, false),
      typeConges: _mapTypeConges(dto),
      portionDebut: portionDebutTr.encode(dto.portionDebut!),
      portionFin: portionFinTr.encode(dto.portionFin!),
      commentaire: dto.commentaire,
      resources: [dto.teammate!.email!],
    );
  }

  CongesPersistDtoTypeCongesEnum _mapTypeConges(CongesDto dto) {
    print('_mapTypeConges $dto');
    CongesPersistDtoTypeCongesEnum type;
    switch (dto.typeConges!) {
      case CongesDtoTypeCongesEnum.CONGE_PAYE:
        type = CongesPersistDtoTypeCongesEnum.CONGE_PAYE;
        break;
      case CongesDtoTypeCongesEnum.MALADIE:
        type = CongesPersistDtoTypeCongesEnum.MALADIE;
        break;
      case CongesDtoTypeCongesEnum.SANS_SOLDE:
        type = CongesPersistDtoTypeCongesEnum.SANS_SOLDE;
        break;
      default:
        type = CongesPersistDtoTypeCongesEnum.CONGE_PAYE;
    }
    return type;
  }

  Future<void> _createConges(Conges conges) {
    return _mapCongesToCreateDto(conges)
        .then((dto) => congesControllerApi.create2(dto))
        .then((congesDto) => Future.value(_mapConges(congesDto!)))
        .then((conges) => _addCongesToAppointments(conges));
  }

  Future<void> _updateConges(Conges conges) {
    return _mapCongesToCreateDto(conges).then((dto) => congesControllerApi.update2(dto)).then((congesDto) {
      _removeCongesFromAppointments(conges);
      _addCongesToAppointments(_mapConges(congesDto!));
    });
  }

  void _removeCongesFromAppointments(Conges conges) {
    final int index = appointments!.indexWhere((element) => element.id == conges.id);
    final congesRead = appointments![index];
    notifyListeners(CalendarDataSourceAction.remove, [congesRead]);
    appointments?.removeAt(index);
  }

  void _addCongesToAppointments(Conges conges) {
    print('_addCongesToAppointments $conges');
    appointments?.add(conges);
    notifyListeners(CalendarDataSourceAction.add, [conges]);
  }

  Future<CongesPersistDto> _mapCongesToCreateDto(Conges conges) {
    return Future(() {
      print('_mapCongesToCreateDto $conges');

      throwIf(conges.resources.isEmpty, Exception('Aucune ressource sélectionnée.'));

      final String emailSelected = (conges.resources.first as String);
      final int? teammateId = listTeammateDto!.firstWhere((teammate) => teammate.email == emailSelected).id;

      throwIf(teammateId == null, Exception('Aucune resource trouvée pour l\'email'));

      return CongesPersistDto(
          id: conges.id,
          teammateId: teammateId!,
          dateDebut: dateFormat.format(conges.dateDebut),
          dateFin: dateFormat.format(conges.dateFin),
          typeConges: conges.typeConges,
          commentaire: conges.commentaire,
          portionDebut: CongesPersistDtoPortionDebutEnum.fromJson(conges.portionDebut)!,
          portionFin: CongesPersistDtoPortionFinEnum.fromJson(conges.portionFin)!);
    });
  }

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
