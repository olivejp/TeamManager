
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/service/firebase_storage_service.dart';

import 'download_file.dart';
import 'file_drop_zone.dart';

class DownloadFileNotifier extends ChangeNotifier {
  DownloadFileNotifier({
    required this.path,
    required this.onUploadComplete,
    this.isLoading = false,
  });

  final FirebaseStorageService storageService = GetIt.I.get<FirebaseStorageService>();

  final String path;
  final void Function(String downloadUrl, String fileName) onUploadComplete;

  bool isLoading;
  int? byteTransferred;
  int? totalBytes;
  UploadTask? uploadTask;
  bool hover = false;

  void onHover() {
    hover = true;
    notifyListeners();
  }

  void onLeave() {
    hover = false;
    notifyListeners();
  }

  void storeDocument(Uint8List? documentBytes, String? documentName, String? mimeType) {
    print('storeDocument has been called');

    if (documentBytes == null) {
      print("Impossible de sauvegarder un CV sans les données de fichier.");
      return;
    }

    if (documentName == null || documentName.isEmpty) {
      print("Impossible de sauvegarder un CV sans le nom du fichier.");
      return;
    }

    String newPath = path;
    if (path.substring(path.length - 1, path.length) != '/') {
      newPath = path + '/';
    }

    final String filename = newPath + documentName;
    final SettableMetadata metadata =
    SettableMetadata(cacheControl: 'max-age=36000', contentType: mimeType ?? 'application/octet-stream');

    isLoading = true;
    notifyListeners();

    // Create an uploadTask
    uploadTask = storageService.uploadDataAsUploadTask(filename, documentBytes, metadata);

    uploadTask?.snapshotEvents.listen((event) {
      totalBytes = event.totalBytes;
      byteTransferred = event.bytesTransferred;
      notifyListeners();
    });

    // When the uploadTask is complete we send back the
    print('Listen whenComplete');
    uploadTask?.whenComplete(() {
      print('uploadTask complete');
      uploadTask?.snapshot.ref.getDownloadURL().then((downloadUrl) {
        onUploadComplete(downloadUrl, filename);
      });
      isLoading = false;
      uploadTask = null;
      notifyListeners();
    });
  }
}

class DownloadFileWidget extends StatelessWidget {
  const DownloadFileWidget({
    Key? key,
    required this.onUploadComplete,
    required this.width,
    required this.height,
    required this.acceptedMimeTypes,
    required this.path,
    this.downloadUrl,
    this.filename,
    this.onDelete,
  }) : super(key: key);

  final String path;
  final double width;
  final double height;
  final List<String> acceptedMimeTypes;
  final String? downloadUrl;
  final String? filename;
  final Future<void> Function()? onDelete;
  final void Function(String downloadUrl, String fileName) onUploadComplete;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: true,
      create: (_) => DownloadFileNotifier(
        path: path,
        onUploadComplete: onUploadComplete,
      ),
      child: Consumer<DownloadFileNotifier>(builder: (_, notifier, __) {
        if (notifier.isLoading) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.grey,
                style: BorderStyle.solid,
              ),
            ),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                backgroundColor: Colors.grey,
                value: (notifier.byteTransferred != null && notifier.totalBytes != null)
                    ? notifier.byteTransferred! / notifier.totalBytes!
                    : null,
              ),
            ),
          );
        }
        if (downloadUrl != null && filename != null) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.grey,
                style: BorderStyle.solid,
              ),
            ),
            child: DownloadFile(
              filename: filename!,
              downloadUrl: downloadUrl!,
              displayDeleteButton: true,
              onDelete: onDelete,
            ),
          );
        } else {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: notifier.hover ? Colors.blue : Colors.grey,
                style: BorderStyle.solid,
              ),
            ),
            child: FileDropZone(
              onHover: notifier.onHover,
              onLeave: notifier.onLeave,
              onDrop: notifier.storeDocument,
              acceptedMimeTypes: acceptedMimeTypes,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Déposer ici le CV'),
                  TextButton.icon(
                    onPressed: () {
                      FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf', 'jpeg', 'jpg']).then((FilePickerResult? result) {
                        if (result != null) {
                          final Uint8List? fileBytes = result.files.first.bytes;
                          final String fileName = result.files.first.name;
                          notifier.storeDocument(fileBytes, fileName, mimeFromExtension(fileName));
                        }
                      });
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Upload un fichier'),
                  )
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
