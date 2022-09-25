import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:team_manager/openapi/api.dart';
import 'package:team_manager/page/planning/planning_conges.dart';
import 'package:team_manager/service/user_connected_service.dart';

class CongesWidgetNotifier extends ChangeNotifier {
  final DateFormat dateFormat = DateFormat('EEEE dd MMMM yyyy - HH:mm', 'fr_FR');
  final UserConnectedService userConnectedService = GetIt.I.get();

  final Conges conges;
  final TextEditingController dateDebutController;
  final TextEditingController dateFinController;
  final TextEditingController commentaireController;

  TeammateDto? teammateConnected;
  List<bool> listToggleSelected = [true, false, false];
  List<bool> listToggleDebut = [true, false];
  List<bool> listToggleFin = [true, false];

  CongesWidgetNotifier(
    this.conges,
    this.dateDebutController,
    this.dateFinController,
    this.commentaireController,
  ) {
    teammateConnected = userConnectedService.user;
    setDateDebut(conges.dateDebut);
    setDateFin(conges.dateFin);
    setCommentaire(conges.commentaire);
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
    conges.dateDebut = getDateDebut(dateDebut);
    dateDebutController.text = dateToString(conges.dateDebut);
  }

  setDateFin(DateTime? dateFin) {
    if (dateFin == null) return;
    conges.dateFin = getDateFin(dateFin);
    dateFinController.text = dateToString(conges.dateFin);
  }

  TimeOfDay getHeureDebut() {
    return TimeOfDay(hour: (listToggleDebut[0]) ? 7 : 12, minute: 00);
  }

  TimeOfDay getHeureFin() {
    return TimeOfDay(hour: (listToggleFin[0]) ? 11 : 16, minute: 00);
  }

  DateTime getDateDebut(DateTime date) {
    final TimeOfDay heureDebut = getHeureDebut();
    return DateTime(date.year, date.month, date.day, heureDebut.hour, heureDebut.minute);
  }

  DateTime getDateFin(DateTime date) {
    final TimeOfDay heureFin = getHeureFin();
    return DateTime(date.year, date.month, date.day, heureFin.hour, heureFin.minute);
  }

  save(GlobalKey<FormState> formKey, Function(Conges meeting) onSave) {
    if (formKey.currentState?.validate() == true) {
      /// Création d'un objet à envoyer à la fonction de sauvegarde

      final Conges congesToSave = Conges(
          id: conges.id,
          typeConges: conges.typeConges,
          dateDebut: conges.dateDebut,
          dateFin: conges.dateFin,
          commentaire: conges.commentaire,
          resources: [teammateConnected!.email!]);

      /// Appel de la fonction de sauvegarde reçue en paramètre
      onSave(congesToSave);
    }
  }

  selectToggle(int index) {
    listToggleSelected = [false, false, false];
    listToggleSelected[index] = true;
    conges.typeConges = CongesCreateDtoTypeCongesEnum.values[index];
    notifyListeners();
  }

  setToggleDebut(int index) {
    listToggleDebut = [false, false];
    listToggleDebut[index] = true;
    conges.dateDebut = getDateDebut(conges.dateDebut);
    dateDebutController.text = dateToString(conges.dateDebut);
    notifyListeners();
  }

  setToggleFin(int index) {
    listToggleFin = [false, false];
    listToggleFin[index] = true;
    conges.dateFin = getDateFin(conges.dateFin);
    dateFinController.text = dateToString(conges.dateFin);
    notifyListeners();
  }
}
