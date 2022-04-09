import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../domain/teamate.dart';
import '../service/service_teamate.dart';

class TeamateVisualizeNotifier extends ChangeNotifier {
  final ServiceTeamate service = GetIt.I.get<ServiceTeamate>();
  Teamate? teamateToVisualize;
  bool isReadOnly = true;
  bool isCreationMode = false;

  Future<List<Teamate>> getListTeamate() {
    return service.getAll(jsonRoot: ['_embedded', 'teamate'], queryParams: {'sort': 'id asc'});
  }

  void changeToCreationMode() {
    isCreationMode = true;
    isReadOnly = false;
    teamateToVisualize = Teamate();
    notifyListeners();
  }

  void changeReadOnly() {
    isReadOnly = !isReadOnly;
    notifyListeners();
  }

  Future<void> delete(int id) {
    return service.delete(id).then((value) => notifyListeners());
  }

  Future<void> save(GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() == true) {
      if (teamateToVisualize != null) {
        Future<void> callToMake;
        if (isCreationMode) {
          callToMake = service.create(teamateToVisualize!);
        } else {
          callToMake = service.update(teamateToVisualize!);
        }

        return callToMake.then((value) {
          isReadOnly = true;
          notifyListeners();
        });
      }
    }
    return Future.error('There is errors on this page.');
  }

  void setNewTeamateToVisualize(int? idTeamate) {
    isReadOnly = true;
    isCreationMode = false;

    if (idTeamate != null) {
      service.read(idTeamate).then((teamateRead) {
        teamateToVisualize = teamateRead;
        notifyListeners();
      });
    } else {
      teamateToVisualize = null;
      notifyListeners();
    }
  }

  setLastname(String? newName) {
    teamateToVisualize?.nom = newName;
  }

  setFirstname(String? newPrenom) {
    teamateToVisualize?.prenom = newPrenom;
  }

  setBirthdate(DateTime? newDateNaissance) {
    teamateToVisualize?.dateNaissance = newDateNaissance;
  }
}
