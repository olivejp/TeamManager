import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:team_manager/openapi/api.dart';
import 'package:team_manager/page/planning/planning_conges.dart';

class CongesWidgetNotifier extends ChangeNotifier {
  final DateFormat dateFormat = DateFormat('EEEE dd MMMM yyyy', 'fr_FR');

  final CongesCreateDtoPortionDebutEnumTypeTransformer _portionDebutEnumTypeTransformer =
      CongesCreateDtoPortionDebutEnumTypeTransformer();
  final CongesCreateDtoPortionFinEnumTypeTransformer _portionFinEnumTypeTransformer =
      CongesCreateDtoPortionFinEnumTypeTransformer();

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
    conges.dateDebut = DateTime(
        conges.dateDebut.year, conges.dateDebut.month, conges.dateDebut.day, index == 0 ? 0 : 11, index == 0 ? 0 : 59);
    dateDebutController.text = dateToString(conges.dateDebut);
    notifyListeners();
  }

  setToggleFin(int index) {
    conges.portionFin = _portionFinEnumTypeTransformer
        .encode((index == 0) ? CongesCreateDtoPortionFinEnum.MATIN : CongesCreateDtoPortionFinEnum.APRES_MIDI);
    conges.dateFin = DateTime(
        conges.dateFin.year, conges.dateFin.month, conges.dateFin.day, index == 0 ? 12 : 23, index == 0 ? 0 : 59);
    dateFinController.text = dateToString(conges.dateFin);
    notifyListeners();
  }
}
