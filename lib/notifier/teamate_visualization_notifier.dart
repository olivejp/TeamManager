import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:team_manager/domain/competence.dart';
import 'package:team_manager/domain/document.dart';
import 'package:team_manager/service/firebase_storage_service.dart';
import 'package:team_manager/service/service_competence.dart';
import 'package:team_manager/service/service_document.dart';

import '../domain/teamate.dart';
import '../service/service_teamate.dart';

class TeamateVisualizeNotifier extends ChangeNotifier {
  final ServiceTeamate service = GetIt.I.get<ServiceTeamate>();
  final DocumentService documentService = GetIt.I.get<DocumentService>();
  final CompetenceService competenceService = GetIt.I.get<CompetenceService>();
  final FirebaseStorageService storageService = GetIt.I.get<FirebaseStorageService>();
  Teamate? teamateToVisualize;
  UploadTask? uploadPhotoTask;
  UploadTask? uploadCvTask;
  bool isReadOnly = true;
  bool isCreationMode = false;
  String sort = 'id';

  void changeSort(String s) {
    sort = s;
    notifyListeners();
  }

  Future<List<Teamate>> getListTeamate() {
    return service.getAll(jsonRoot: ['content'], queryParams: {'sort': sort + ',asc'});
  }

  void changeToCreationMode() {
    isCreationMode = true;
    isReadOnly = false;
    teamateToVisualize = Teamate();
    notifyListeners();
  }

  void changeReadOnly() {
    print('Change readOnly');
    isReadOnly = !isReadOnly;
    notifyListeners();
  }

  Future<void> delete(int id) {
    return service.delete(id).then((value) => notifyListeners());
  }

  Future<Teamate> checkAndSave(GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() == true) {
      return save();
    }
    return Future.error('There is errors on this page.');
  }

  Future<Teamate> save() {
    if (teamateToVisualize == null) {
      return Future.error('There is no Teamate to save.');
    }

    final Future<Teamate> callToMake =
        (isCreationMode) ? service.create(teamateToVisualize!) : service.update(teamateToVisualize!);

    return callToMake.then((teamate) {
      teamateToVisualize = teamate;
      isReadOnly = true;
      isCreationMode = false;
      notifyListeners();
      return teamate;
    });
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

  void setListCompetence(dynamic returnValue) {
    final List<dynamic> listCompetenceId = returnValue;
    final List<Competence> list = listCompetenceId.map((e) {
      final Competence competence = Competence();
      competence.id = int.parse(e);
      return competence;
    }).toList();
    teamateToVisualize?.listCompetence = list;
    save();
  }

  void addDocument(String downloadUrl, String filename) {
    if (teamateToVisualize?.id != null) {
      final Document document = Document();
      document.id = null;
      document.url = downloadUrl;
      document.filename = filename;
      teamateToVisualize?.listDocument?.add(document);
      save();
    }
  }

  Future<void> deleteDocument(Document e) {
    if (teamateToVisualize?.id == null) {
      return Future.error('Aucun ID utilisateur pour la suppression du document.');
    }
    if (e.id == null) {
      return Future.error('Aucun ID document pour la suppression du document.');
    }

    teamateToVisualize!.listDocument?.remove(e);

    return storageService
        .deleteFile(e.filename!)
        .whenComplete(() => documentService.delete(e.id!))
        .whenComplete(() => setNewTeamateToVisualize(teamateToVisualize?.id))
        .onError((error, stackTrace) => print('DELETION FAILED' + (error?.toString() ?? "")));
  }
}
