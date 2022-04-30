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

  static const String applicationOctetStream = 'application/octet-stream';
  static const String maxAge = 'max-age=36000';

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
    hover = false;

    if (documentBytes == null) {
      return;
    }

    if (documentName == null || documentName.isEmpty) {
      return;
    }

    String newPath = path;
    if (path.substring(path.length - 1, path.length) != '/') {
      newPath = path + '/';
    }

    final String filename = newPath + documentName;
    final SettableMetadata metadata =
        SettableMetadata(cacheControl: maxAge, contentType: mimeType ?? applicationOctetStream);

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
    uploadTask?.whenComplete(() {
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
    required this.acceptedExtensions,
    required this.path,
    required this.label,
    required this.buttonLabel,
    this.downloadUrl,
    this.filename,
    this.onDelete,
    this.isReadOnly = false,
    this.radius
  }) : super(key: key);

  final String path;
  final double width;
  final double height;
  final List<String> acceptedMimeTypes;
  final List<String> acceptedExtensions;
  final String? downloadUrl;
  final String? filename;
  final Future<void> Function()? onDelete;
  final void Function(String downloadUrl, String fileName) onUploadComplete;
  final bool isReadOnly;
  final String label;
  final String buttonLabel;
  final BorderRadius? radius;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DownloadFileNotifier(
        path: path,
        onUploadComplete: onUploadComplete,
      ),
      child: Consumer<DownloadFileNotifier>(builder: (_, notifier, __) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: radius ?? BorderRadius.circular(5),
            border: Border.all(
              color: (notifier.hover && !isReadOnly) ? Theme.of(context).colorScheme.primary : Colors.grey,
              style: BorderStyle.solid,
            ),
          ),
          child: Builder(
            builder: (context) {
              if (notifier.isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                    backgroundColor: Colors.grey,
                    value: (notifier.byteTransferred != null && notifier.totalBytes != null)
                        ? notifier.byteTransferred! / notifier.totalBytes!
                        : null,
                  ),
                );
              } else if (downloadUrl != null && filename != null) {
                return DownloadFile(
                  filename: filename!,
                  downloadUrl: downloadUrl!,
                  displayDeleteButton: !isReadOnly,
                  onDelete: onDelete,
                );
              } else {
                return FileDropZone(
                  onDrop: (data, filename, mimeType) {
                    if (!isReadOnly) {
                      notifier.storeDocument(data, filename, mimeType);
                    }
                  },
                  onHover: notifier.onHover,
                  onLeave: notifier.onLeave,
                  acceptedMimeTypes: acceptedMimeTypes,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(label,
                          style: (isReadOnly)
                              ? Theme.of(context).textTheme.caption?.copyWith(color: Colors.grey)
                              : Theme.of(context).textTheme.caption?.copyWith(color: Colors.white)),
                      TextButton.icon(
                        icon: const Icon(Icons.upload_file),
                        label: Text(buttonLabel),
                        onPressed: (isReadOnly)
                            ? null
                            : () {
                                FilePicker.platform
                                    .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: acceptedExtensions,
                                )
                                    .then((FilePickerResult? result) {
                                  if (result != null) {
                                    final Uint8List? fileBytes = result.files.first.bytes;
                                    final String fileName = result.files.first.name;
                                    notifier.storeDocument(fileBytes, fileName, mimeFromExtension(fileName));
                                  }
                                });
                              },
                      )
                    ],
                  ),
                );
              }
            },
          ),
        );
      }),
    );
  }
}
