import 'dart:typed_data';

class StorageFile {
  StorageFile({this.fileBytes, this.fileName});

  Uint8List? fileBytes;
  String? fileName;
}