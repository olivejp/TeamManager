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
  late Reference storageRef;

  FirebaseStorageService() {
    storageRef = FirebaseStorage.instanceFor(bucket: EnvironmentConfig.resourceManagerStorage).ref();
  }

  /// String path : Create a reference to path.
  /// File file : The file to upload.
  /// SettableMetadata? metadata : The metadata attached to the file.
  /// path could be "mountains.jpg".
  Stream<TaskSnapshot>? uploadFile(String path, File file, SettableMetadata? metadata) {
    final Reference? ref = storageRef.child(path);
    return ref?.putFile(file, metadata).asStream();
  }

  /// String path : Create a reference to path.
  /// Uint8List data : The data to upload.
  /// SettableMetadata? metadata : The metadata attached to the file.
  /// path could be "mountains.jpg".
  Stream<TaskSnapshot>? uploadData(String path, Uint8List data, SettableMetadata? metadata) {
    final Reference? ref = storageRef.child(path);
    return ref?.putData(data, metadata).asStream();
  }

  /// String path : Create a reference to path.
  /// dynamic blob : The blob to upload.
  /// SettableMetadata? metadata : The metadata attached to the file.
  /// path could be "mountains.jpg".
  Stream<TaskSnapshot>? uploadBlob(String path, dynamic blob, SettableMetadata? metadata) {
    final Reference? ref = storageRef.child(path);
    return ref?.putBlob(blob, metadata).asStream();
  }

  /// String path : Create a reference to path.
  /// Uint8List data : The data to upload.
  /// SettableMetadata? metadata : The metadata attached to the file.
  /// path could be "mountains.jpg".
  UploadTask? uploadDataAsUploadTask(String path, Uint8List data, SettableMetadata? metadata) {
    final Reference? ref = storageRef.child(path);
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

  Future<void> deleteFile(String filePath) {
    return storageRef.child(filePath).delete();
  }

  Future<void> deleteFolder(String folderPath) {
    return _deleteFolder(folderPath);
  }

  Future<void> _deleteFolder(String folderPath) async {
    final Reference ref = storageRef.child(folderPath);
    final ListResult directories = await ref.listAll();
    for (var fileRef in directories.items) {
      await _deleteFolderFile(ref.fullPath, fileRef.name);
    }
    for (var folderRef in directories.prefixes) {
      await _deleteFolder(folderRef.fullPath);
    }
  }

  Future<void> _deleteFolderFile(pathToFile, fileName) {
    final Reference ref = storageRef.child(pathToFile);
    final Reference childRef = ref.child(fileName);
    return childRef.delete();
  }
}
