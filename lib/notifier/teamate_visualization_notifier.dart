import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:team_manager/service/firebase_storage_service.dart';

import '../domain/teamate.dart';
import '../service/service_teamate.dart';

class TeamateVisualizeNotifier extends ChangeNotifier {
  final ServiceTeamate service = GetIt.I.get<ServiceTeamate>();
  final FirebaseStorageService storageService = GetIt.I.get<FirebaseStorageService>();
  Teamate? teamateToVisualize;
  UploadTask? uploadTask;
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

  Future<void> checkAndSave(GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() == true) {
      return save();
    }
    return Future.error('There is errors on this page.');
  }

  Future<void> save() {
    if (teamateToVisualize != null) {
      final Future<void> callToMake =
          (isCreationMode) ? service.create(teamateToVisualize!) : service.update(teamateToVisualize!);

      return callToMake.then((value) {
        isReadOnly = true;
        notifyListeners();
      });
    } else {
      return Future.error('There is no Teamate to save.');
    }
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

  void setPhotoUrl(Uint8List? data, String name) {
    if (teamateToVisualize?.id != null && data != null) {
      final String filename = teamateToVisualize!.id!.toString() + '/' + name;
      uploadTask = storageService.uploadDataAsUploadTask(filename, data, null);
      uploadTask?.whenComplete(() {
        uploadTask?.snapshot.ref.getDownloadURL().then((value) {
          teamateToVisualize?.photoUrl = value;
          save();
        });
        uploadTask = null;
      });
    }
  }

  void pauseUpload() {
    if (uploadTask != null) {
      uploadTask!.pause();
    }
  }

  void resumeUpload() {
    if (uploadTask != null) {
      uploadTask!.resume();
    }
  }

  void cancelUpload() {
    if (uploadTask != null) {
      uploadTask!.cancel();
    }
  }
}
