import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:team_manager/openapi/api.dart';

class CompetenceCreationNotifier extends ChangeNotifier {
  CompetenceControllerApi competenceService = GetIt.I.get<CompetenceControllerApi>();
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
      final Competence competence = Competence(nom: nom!);
      return competenceService.create3(competence);
    }
    return Future.error('Formulaire invalide.');
  }

  void setNom(String? newNom) {
    nom = newNom;
  }

  Future<void> delete(int id) {
    return competenceService.delete4(id).then((value) => refresh());
  }

  void refresh() {
    competenceService.getAll3(Pageable()).then((value) {
      listCompetence = value?.content ?? [];
      notifyListeners();
    });
  }
}
