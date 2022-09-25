import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:team_manager/openapi/api.dart';
import 'package:team_manager/page/planning/planning_conges.dart';
import 'package:team_manager/service/user_connected_service.dart';

class CongesWidgetNotifier extends ChangeNotifier {
  final DateFormat dateFormat = DateFormat('EEEE dd MMMM yyyy', 'fr_FR');

  final CongesCreateDtoPortionDebutEnumTypeTransformer _portionDebutEnumTypeTransformer =
      CongesCreateDtoPortionDebutEnumTypeTransformer();
  final CongesCreateDtoPortionFinEnumTypeTransformer _portionFinEnumTypeTransformer =
      CongesCreateDtoPortionFinEnumTypeTransformer();

  final UserConnectedService userConnectedService = GetIt.I.get();

  final Conges conges;
  final TextEditingController dateDebutController;
  final TextEditingController dateFinController;
  final TextEditingController commentaireController;

  TeammateDto? teammateConnected;

  CongesWidgetNotifier(
    this.conges,
    this.dateDebutController,
    this.dateFinController,
    this.commentaireController,
  ) {
    teammateConnected = userConnectedService.user;
    dateDebutController.text = dateToString(conges.dateDebut);
    dateFinController.text = dateToString(conges.dateFin);
    commentaireController.text = conges.commentaire ?? '';
  }

  DateTime stringToDate(String dateAsString) {
    return dateFormat.parse(dateAsString);
  }

  String dateToString(DateTime dateTime) {
    return dateFormat.format(dateTime);
  }

  setCommentaire(String? commentaire) {
    conges.commentaire = commentaire;
  }

  setDateDebut(DateTime? dateDebut) {
    if (dateDebut == null) return;
    conges.dateDebut = dateDebut;
    dateDebutController.text = dateToString(conges.dateDebut);
  }

  setDateFin(DateTime? dateFin) {
    if (dateFin == null) return;
    conges.dateFin = dateFin;
    dateFinController.text = dateToString(conges.dateFin);
  }

  save(GlobalKey<FormState> formKey, Function(Conges conges) onSave) {
    if (formKey.currentState?.validate() == true) {
      conges.resources = [teammateConnected!.email!];
      onSave(conges);
    }
  }

  selectToggle(int index) {
    conges.typeConges = CongesCreateDtoTypeCongesEnum.values[index];
    notifyListeners();
  }

  setToggleDebut(int index) {
    conges.portionDebut = _portionDebutEnumTypeTransformer
        .encode((index == 0) ? CongesCreateDtoPortionDebutEnum.MATIN : CongesCreateDtoPortionDebutEnum.APRES_MIDI);
    dateDebutController.text = dateToString(conges.dateDebut);
    notifyListeners();
  }

  setToggleFin(int index) {
    conges.portionFin = _portionFinEnumTypeTransformer
        .encode((index == 0) ? CongesCreateDtoPortionFinEnum.MATIN : CongesCreateDtoPortionFinEnum.APRES_MIDI);
    dateFinController.text = dateToString(conges.dateFin);
    notifyListeners();
  }
}
