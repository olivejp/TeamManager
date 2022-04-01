import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../domain/teamate.dart';
import '../service/service_teamate.dart';

class TeamateCreationNotifier extends ChangeNotifier {
  ServiceTeamate teamateService = GetIt.I.get<ServiceTeamate>();

  List<Teamate> listTeamate = [];
  Teamate? teamateToUpdate;

  String? nom;
  String? prenom;

  TeamateCreationNotifier() {
    refresh();
  }

  void setNewTeamateToUpdate(Teamate? newTeamate) {
    teamateToUpdate = newTeamate;
    notifyListeners();
  }

  void reset(TextEditingController? nomController, TextEditingController? prenomController) {
    nom = null;
    prenom = null;
    nomController?.clear();
    prenomController?.clear();
    refresh();
  }

  Future<void> create(GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() == true) {
      final Teamate teamate = Teamate(nom: nom, prenom: prenom);
      return teamateService.create(teamate);
    }
    return Future.error('Formulaire invalide.');
  }

  void setNom(String? newNom) {
    nom = newNom;
  }

  void setPrenom(String? newPrenom) {
    prenom = newPrenom;
  }

  Future<void> delete(int id) {
    return teamateService.delete(id).then((value) => refresh());
  }

  void refresh() {
    teamateService.getAll(jsonRoot: ['_embedded', 'teamate'], queryParams: {'sort': 'id asc'}).then((value) {
      listTeamate = value;
      notifyListeners();
    });
  }
}
