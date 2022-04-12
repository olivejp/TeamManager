import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:team_manager/environment_config.dart';

import '../domain/storage_file.dart';

/// For uploading options see : https://firebase.flutter.dev/docs/storage/upload-files
class FirebaseStorageService {
  late FirebaseStorage storageRef;

  FirebaseStorageService() {
    storageRef = FirebaseStorage.instanceFor(bucket: EnvironmentConfig.resourceManagerStorage);
  }

  /// String path : Create a reference to path.
  /// File file : The file to upload.
  /// SettableMetadata? metadata : The metadata attached to the file.
  /// path could be "mountains.jpg".
  Stream<TaskSnapshot>? uploadFile(String path, File file, SettableMetadata? metadata) {
    final Reference? ref = storageRef.ref().child(path);
    return ref?.putFile(file, metadata).asStream();
  }

  /// String path : Create a reference to path.
  /// Uint8List data : The data to upload.
  /// SettableMetadata? metadata : The metadata attached to the file.
  /// path could be "mountains.jpg".
  Stream<TaskSnapshot>? uploadData(String path, Uint8List data, SettableMetadata? metadata) {
    final Reference? ref = storageRef.ref().child(path);
    return ref?.putData(data, metadata).asStream();
  }

  /// String path : Create a reference to path.
  /// dynamic blob : The blob to upload.
  /// SettableMetadata? metadata : The metadata attached to the file.
  /// path could be "mountains.jpg".
  Stream<TaskSnapshot>? uploadBlob(String path, dynamic blob, SettableMetadata? metadata) {
    final Reference? ref = storageRef.ref().child(path);
    return ref?.putBlob(blob, metadata).asStream();
  }

  /// String path : Create a reference to path.
  /// Uint8List data : The data to upload.
  /// SettableMetadata? metadata : The metadata attached to the file.
  /// path could be "mountains.jpg".
  UploadTask? uploadDataAsUploadTask(String path, Uint8List data, SettableMetadata? metadata) {
    final Reference? ref = storageRef.ref().child(path);
    return ref?.putData(data, metadata);
  }

  /// Permet de récupérer le StorageFile à partir d'une adresse url.
  Future<StorageFile?> getFutureStorageFile(String? imageUrl) {
    final Completer<StorageFile?> completer = Completer<StorageFile?>();
    if (imageUrl != null && imageUrl.isNotEmpty) {
      _getRemoteImageToUint8List(imageUrl).then((Uint8List bytes) {
        final StorageFile storageFile = StorageFile();
        storageFile.fileName = basename(imageUrl);
        storageFile.fileBytes = bytes;
        completer.complete(storageFile);
      });
    } else {
      completer.complete(null);
    }
    return completer.future;
  }

  /// Permet de récupérer le binaire d'un fichier à partir de son adresse url.
  Future<Uint8List> _getRemoteImageToUint8List(String imageUrl) {
    return http.readBytes(Uri.parse(imageUrl));
  }
}
