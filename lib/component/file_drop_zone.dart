
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class FileDropZone extends StatelessWidget {
  const FileDropZone({
    Key? key,
    required this.onDrop,
    this.acceptedMimeTypes,
    this.child,
    this.cursorType,
    this.onHover,
    this.onLeave,
  }) : super(key: key);
  final CursorType? cursorType;
  final List<String>? acceptedMimeTypes;
  final Widget? child;
  final Function(Uint8List? data, String? filename, String? mimeType) onDrop;
  final Function()? onHover;
  final Function()? onLeave;

  @override
  Widget build(BuildContext context) {
    DropzoneViewController? controller;
    return Stack(
      children: [
        DropzoneView(
          mime: acceptedMimeTypes,
          operation: DragOperation.copy,
          cursor: cursorType,
          onCreated: (ctrl) => controller = ctrl,
          onLoaded: () => print('Zone loaded'),
          onError: (String? ev) => print('Ca barre en couille : $ev'),
          onHover: onHover,
          onLeave: onLeave,
          onDrop: (dynamic ev) async {
            final Uint8List? data = await controller?.getFileData(ev);
            final String? fileName = await controller?.getFilename(ev);
            final String? mimeType = await controller?.getFileMIME(ev);
            onDrop(data, fileName, mimeType);
          },
        ),
        Center(child: child ?? Container())
      ],
    );
  }
}
