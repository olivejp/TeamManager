import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:team_manager/domain/competence.dart';
import 'package:team_manager/service/service_competence.dart';

class CompetenceCreationNotifier extends ChangeNotifier {
  CompetenceService competenceService = GetIt.I.get<CompetenceService>();
  List<Competence> listCompetence = [];
  String? nom;

  CompetenceCreationNotifier() {
    refresh();
  }

  void reset(TextEditingController? nomController) {
    nom = null;
    nomController?.clear();
    refresh();
  }

  Future<void> create(GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() == true) {
      final Competence competence = Competence(nom: nom);
      return competenceService.create(competence);
    }
    return Future.error('Formulaire invalide.');
  }

  void setNom(String? newNom) {
    nom = newNom;
  }

  Future<void> delete(int id) {
    return competenceService.delete(id).then((value) => refresh());
  }

  void refresh() {
    competenceService.getAll(jsonRoot: ['_embedded', 'competence'], queryParams: {'sort': 'id asc'}).then((value) {
      listCompetence = value;
      notifyListeners();
    });
  }
}
