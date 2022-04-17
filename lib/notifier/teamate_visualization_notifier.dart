import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:team_manager/domain/competence.dart';
import 'package:team_manager/service/firebase_storage_service.dart';
import 'package:team_manager/service/service_competence.dart';

import '../domain/teamate.dart';
import '../service/service_teamate.dart';

class TeamateVisualizeNotifier extends ChangeNotifier {
  final ServiceTeamate service = GetIt.I.get<ServiceTeamate>();
  final CompetenceService competenceService = GetIt.I.get<CompetenceService>();
  final FirebaseStorageService storageService = GetIt.I.get<FirebaseStorageService>();
  Teamate? teamateToVisualize;
  UploadTask? uploadPhotoTask;
  UploadTask? uploadCvTask;
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

  setDescription(String value) {
    teamateToVisualize?.description = value;
  }

  Future<List<Competence>> getAllCompetence() {
    return competenceService.getAll(jsonRoot: ['_embedded', 'competence'], queryParams: {'sort': 'id asc'});
  }

  void setPhotoUrl(Uint8List? data, String name) {
    if (teamateToVisualize?.id != null && data != null) {
      final String filename = teamateToVisualize!.id!.toString() + '/photo/' + name;
      String contentType;

      switch (extension(name).toLowerCase()) {
        case '.jpg':
        case '.jpeg':
          contentType = 'image/jpeg';
          break;
        case '.png':
          contentType = 'image/png';
          break;
        case '.gif':
          contentType = 'image/gif';
          break;
        default:
          contentType = 'application/octet-stream';
      }

      final SettableMetadata metadata = SettableMetadata(cacheControl: 'max-age=36000', contentType: contentType);

      uploadPhotoTask = storageService.uploadDataAsUploadTask(filename, data, metadata);
      uploadPhotoTask?.whenComplete(() {
        uploadPhotoTask?.snapshot.ref.getDownloadURL().then((downloadUrl) {
          teamateToVisualize?.photoUrl = downloadUrl;
          save();
        });
        uploadPhotoTask = null;
      });
    }
  }

  void setCv(String downloadUrl, String filename) {
    teamateToVisualize?.cvUrl = downloadUrl;
    teamateToVisualize?.cvFilename = filename;
    save();
  }

  void pausePhotoUpload() {
    if (uploadPhotoTask != null) {
      uploadPhotoTask!.pause();
    }
  }

  void resumePhotoUpload() {
    if (uploadPhotoTask != null) {
      uploadPhotoTask!.resume();
    }
  }

  void cancelPhotoUpload() {
    if (uploadPhotoTask != null) {
      uploadPhotoTask!.cancel();
    }
  }

  void deletePhotoUrl() {
    if (teamateToVisualize != null && teamateToVisualize?.id != null) {
      teamateToVisualize!.photoUrl = null;
      save().then((value) => storageService
          .deleteFolder(teamateToVisualize!.id.toString() + '/photo')
          .then((value) => print('DELETION COMPLETED'))
          .onError((error, stackTrace) => print('DELETION FAILED' + (error?.toString() ?? ""))));
    }
  }

  Future<void> deleteCv() async {
    if (teamateToVisualize != null && teamateToVisualize?.id != null) {
      teamateToVisualize!.cvUrl = null;
      teamateToVisualize!.cvFilename = null;
      return save().then((value) => storageService
          .deleteFolder(teamateToVisualize!.id.toString() + '/cv')
          .then((value) => notifyListeners())
          .onError((error, stackTrace) => print('DELETION FAILED' + (error?.toString() ?? ""))));
    }
  }

  void setListCompetence(dynamic returnValue) {
    final List<dynamic> listCompetenceId = returnValue;
    print(listCompetenceId);
    final List<Competence> list = listCompetenceId.map((e) {
      final Competence competence = Competence();
      competence.id = int.parse(e);
      return competence;
    }).toList();
    teamateToVisualize?.listCompetence = list;
    save();
  }
}
