import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:team_manager/domain/competence.dart';
import 'package:team_manager/domain/document.dart';
import 'package:team_manager/domain/json_patch.dart';
import 'package:team_manager/service/firebase_storage_service.dart';
import 'package:team_manager/service/service_competence.dart';
import 'package:team_manager/service/service_document.dart';
import 'package:team_manager/service/service_toast.dart';

import '../domain/teamate.dart';
import '../service/service_teamate.dart';

class TeamateVisualizeNotifier extends ChangeNotifier {
  final ServiceTeamate service = GetIt.I.get<ServiceTeamate>();
  final ServiceToast serviceToast = GetIt.I.get<ServiceToast>();
  final DocumentService documentService = GetIt.I.get<DocumentService>();
  final CompetenceService competenceService = GetIt.I.get<CompetenceService>();
  final FirebaseStorageService storageService = GetIt.I.get<FirebaseStorageService>();

  Teamate? teamateToVisualize;
  UploadTask? uploadPhotoTask;
  UploadTask? uploadCvTask;
  bool isReadOnly = true;
  bool isCompetencePanelExpanded = false;
  bool isCreationMode = false;
  String sort = 'id';

  void switchCompetencePanelExpanded() {
    isCompetencePanelExpanded = !isCompetencePanelExpanded;
  }

  void changeSort(String s) {
    sort = s;
    notifyListeners();
  }

  Future<List<Teamate>> getListTeamate() {
    return service.getAll(
      jsonRoot: ['content'],
      queryParams: {'sort': sort + ',asc'},
      timeout: const Duration(seconds: 5),
    );
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
    return service.delete(id).then((value) {
      serviceToast.addToast(message: 'Suppression effectu??e', level: ToastLevel.success);
      notifyListeners();
    });
  }

  Future<Teamate> checkAndSave(GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() == true) {
      return saveCurrentTeammate();
    }
    return Future.error('There is errors on this page.');
  }

  Future<Teamate> saveCurrentTeammate({bool setToReadonlyAfter = true, bool exitCreationMode = true}) {
    if (teamateToVisualize == null) {
      return Future.error('There is no Teammate to save.');
    }

    final Future<Teamate> callToMake =
        (isCreationMode) ? service.create(teamateToVisualize!) : service.update(teamateToVisualize!);

    return callToMake.then((teamate) {
      teamateToVisualize = teamate;
      isReadOnly = setToReadonlyAfter;
      isCreationMode = !exitCreationMode;
      notifyListeners();
      serviceToast.addToast(
        message: 'Sauvegarde effectu??e',
        level: ToastLevel.success,
        iconData: Icons.save,
      );
      return teamate;
    });
  }

  void setNewTeamateToVisualize(int? idTeamate, {bool setToReadOnly = true, bool setToCreationMode = false}) {
    isReadOnly = setToReadOnly;
    isCreationMode = setToCreationMode;

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

  setListCompetence(List<Competence> listCompetence) {
    teamateToVisualize?.listCompetence = listCompetence;
  }

  Future<List<Competence>> getAllCompetence() {
    return competenceService.getAll(jsonRoot: ['content'], queryParams: {'sort': 'id,asc'});
  }

  Future<Object?> setPhotoUrl(Uint8List? data, String name) {
    if (teamateToVisualize?.id == null) {
      return Future.error("Aucun id");
    }

    if (data == null) {
      return Future.error("Aucune donn??e");
    }

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
    final Completer<Object?> completer = Completer<Object?>();
    final int idTeammate = teamateToVisualize!.id!;

    uploadPhotoTask = storageService.uploadDataAsUploadTask(filename, data, metadata);
    uploadPhotoTask?.whenComplete(() {
      uploadPhotoTask?.snapshot.ref.getDownloadURL().then((downloadUrl) {
        final JsonPatchObject replacePhotoUrl = JsonPatchObject.replacePatch('/photoUrl', downloadUrl);
        service
            .patch(id: idTeammate, body: replacePhotoUrl, headers: {"Content-Type": "application/json-patch+json"})
            .then((value) => completer.complete(value))
            .onError((error, stackTrace) => completer.completeError(error!));
      });
      uploadPhotoTask = null;
    }).catchError((error, stackTrace) => completer.completeError(error));

    return completer.future;
  }

  Future<void> deletePhotoUrl() async {
    if (teamateToVisualize == null) {
      return Future.error('Aucun teamate');
    }

    if (teamateToVisualize?.id == null) {
      return Future.error('Aucune ID');
    }

    teamateToVisualize!.photoUrl = null;
    return saveCurrentTeammate(setToReadonlyAfter: false, exitCreationMode: true)
        .then((value) => storageService.deleteFolder(teamateToVisualize!.id.toString() + '/photo'))
        .then((value) => serviceToast.addToast(message: 'Suppression photo effectu??e', level: ToastLevel.success));
  }

  void addDocument(String downloadUrl, String filename) {
    if (teamateToVisualize?.id != null) {
      final Document document = Document();
      document.id = null;
      document.url = downloadUrl;
      document.filename = filename;
      teamateToVisualize?.listDocument?.add(document);
      saveCurrentTeammate(setToReadonlyAfter: false);
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

    storageService
        .deleteFile(e.filename!)
        .then((value) => serviceToast.addToast(message: 'Document supprim?? du storage.', level: ToastLevel.success))
        .onError((error, stackTrace) =>
            serviceToast.addToast(message: 'Le document n\'a pas ??t?? supprim?? du storage.', level: ToastLevel.error));

    return documentService
        .delete(e.id!)
        .then((_) => setNewTeamateToVisualize(teamateToVisualize?.id, setToReadOnly: false))
        .then((_) => serviceToast.addToast(message: 'Document correctement supprim??.', level: ToastLevel.success))
        .onError((error, stackTrace) => serviceToast.addToast(
              message: 'Erreur lors de la suppression du document : ' + error.toString(),
              level: ToastLevel.error,
            ));
  }
}
