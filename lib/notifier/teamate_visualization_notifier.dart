import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image/image.dart' as image;
import 'package:intl/intl.dart';
import 'package:team_manager/openapi/api.dart';
import 'package:team_manager/service/firebase_storage_service.dart';
import 'package:team_manager/service/toast_service.dart';

class TeamateVisualizeNotifier extends ChangeNotifier {
  final ToastService serviceToast = GetIt.I.get<ToastService>();
  final FirebaseStorageService storageService = GetIt.I.get<FirebaseStorageService>();
  final TeammateControllerApi service = GetIt.I.get<TeammateControllerApi>();
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  TeammateDto? teammateToVisualize;
  UploadTask? uploadPhotoTask;
  UploadTask? uploadCvTask;
  bool isReadOnly = true;
  bool isCompetencePanelExpanded = false;
  bool isCreationMode = false;
  String sort = 'id';

  DateTime stringToDate(String dateAsString) {
    return dateFormat.parse(dateAsString);
  }

  String dateToString(DateTime dateTime) {
    return dateFormat.format(dateTime);
  }

  void switchCompetencePanelExpanded() {
    isCompetencePanelExpanded = !isCompetencePanelExpanded;
  }

  void changeSort(String s) {
    sort = s;
    notifyListeners();
  }

  Future<List<TeammateDto>> getListTeamate() async {
    final page = await service.getAll(Pageable());
    return page!.content;
  }

  void changeToCreationMode() {
    isCreationMode = true;
    isReadOnly = false;
    teammateToVisualize = TeammateDto();
    notifyListeners();
  }

  void changeReadOnly() {
    print('Change readOnly');
    isReadOnly = !isReadOnly;
    notifyListeners();
  }

  void setBirthdateAsString(String value) {
    try {
      final DateTime dateFinParsed = dateFormat.parse(value);
      teammateToVisualize!.dateNaissance = dateFinParsed;
    } catch (exception) {
      print('Date impossible à formatter.');
    }
  }

  Future<void> delete(int id) {
    return service.delete(id).then((value) {
      serviceToast.addToast(message: 'Suppression effectuée', level: ToastLevel.success);
      notifyListeners();
    });
  }

  Future<TeammateDto?> checkAndSave(GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() == true) {
      return saveCurrentTeammate();
    }
    return Future.error('There is errors on this page.');
  }

  Future<TeammateDto?> saveCurrentTeammate({bool setToReadonlyAfter = true, bool exitCreationMode = true}) {
    if (teammateToVisualize == null) {
      return Future.error('There is no Teammate to save.');
    }

    final Future<TeammateDto?> callToMake =
        (isCreationMode) ? service.create(teammateToVisualize!) : service.update(teammateToVisualize!);

    return callToMake.then((teammate) {
      teammateToVisualize = teammate;
      isReadOnly = setToReadonlyAfter;
      isCreationMode = !exitCreationMode;

      notifyListeners();

      serviceToast.addToast(
        message: 'Sauvegarde effectuée',
        level: ToastLevel.success,
        iconData: Icons.save,
      );

      return teammate;
    });
  }

  void setNewTeamateToVisualize(int? idTeamate, {bool setToReadOnly = true, bool setToCreationMode = false}) {
    isReadOnly = setToReadOnly;
    isCreationMode = setToCreationMode;

    if (idTeamate != null) {
      service.callGet(idTeamate).then((teamateRead) {
        teammateToVisualize = teamateRead;
        notifyListeners();
      });
    } else {
      teammateToVisualize = null;
      notifyListeners();
    }
  }

  setLastname(String? newName) {
    teammateToVisualize?.nom = newName;
  }

  setFirstname(String? newPrenom) {
    teammateToVisualize?.prenom = newPrenom;
  }

  setBirthdate(DateTime? newBirthdate, TextEditingController birthdateController) {
    teammateToVisualize?.dateNaissance = newBirthdate;
    birthdateController.text = dateToString(newBirthdate!);
  }

  setDescription(String value) {
    teammateToVisualize?.description = value;
  }

  Future<String> resizeImage(Uint8List data, {int resizeWidth = 120}) {
    return Future(() {
      final decodedImage = image.decodeImage(data) as image.Image;
      final thumbnail = image.copyResize(decodedImage, width: 120);
      final String base64 = base64Encode(thumbnail.getBytes());
      return base64;
    });
  }

  Future<String> waitForResize(Uint8List data) {
    final Completer<String> completer = Completer();
    resizeImage(data).then((value) => completer.complete(value));
    return completer.future;
  }

  void setPhotoUrl(String base64Image) {
    teammateToVisualize?.photo = base64Image;
  }

  void deletePhotoUrl() {
    teammateToVisualize?.photo = null;
  }

  void addDocument(String downloadUrl, String fileName) {}
}
