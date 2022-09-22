import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:team_manager/domain/storage_file.dart';
import 'package:tuple/tuple.dart';

class PhotoStorageWidget extends StatelessWidget {
  PhotoStorageWidget({
    Key? key,
    required this.onSaved,
    required this.allowedExtensions,
    this.fit = BoxFit.fill,
    this.imageUrl,
    this.imageData,
    this.onDeleted,
    this.width = 200,
    this.height = 300,
    this.emptyColor,
    this.borderRadius,
    this.saveTooltip = "Save",
    this.deleteTooltip = "Delete",
    this.isReadOnly = false,
    this.imageBase64,
  }) : super(key: key) {
    if (imageBase64 != null) {
      vlImage.value = Tuple2(imageUrl, base64Decode(imageBase64!));
    } else {
      vlImage.value = Tuple2(imageUrl, imageData);
    }
  }

  final ValueNotifier<Tuple2<String?, Uint8List?>> vlImage = ValueNotifier(const Tuple2(null, null));
  final String? imageUrl;
  final Uint8List? imageData;
  final Function(StorageFile storageFile) onSaved;
  final void Function()? onDeleted;
  final List<String> allowedExtensions;
  final double width;
  final double height;
  final Color? emptyColor;
  final BoxFit fit;
  final String saveTooltip;
  final String deleteTooltip;
  final BorderRadiusGeometry? borderRadius;
  final bool isReadOnly;
  final String? imageBase64;

  @override
  Widget build(BuildContext context) {
    final Color color = emptyColor ?? Theme.of(context).colorScheme.primary;
    return ValueListenableBuilder<Tuple2<String?, Uint8List?>>(
      valueListenable: vlImage,
      builder: (BuildContext context, Tuple2<String?, Uint8List?>? tuple, Widget? child) {
        return Container(
          clipBehavior: Clip.antiAlias,
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _getImageWidget(tuple),
              _getActionButtons(tuple),
            ],
          ),
        );
      },
    );
  }

  Widget _getActionButtons(Tuple2<String?, Uint8List?>? tuple) {
    if (isReadOnly) {
      return Container();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _onPress,
            tooltip: saveTooltip,
            icon: const Icon(
              Icons.add_rounded,
            ),
          ),
          _hasImage(tuple)
              ? IconButton(
                  onPressed: _onDelete,
                  tooltip: deleteTooltip,
                  icon: const Icon(
                    Icons.delete_rounded,
                  ),
                )
              : Container(),
        ],
      );
    }
  }

  bool _hasImage(Tuple2<String?, Uint8List?>? tuple) {
    return (tuple != null &&
        ((tuple.item2 != null && tuple.item2!.isNotEmpty) || (tuple.item1 != null && tuple.item1!.isNotEmpty)));
  }

  Widget _getImageWidget(Tuple2<String?, Uint8List?>? tuple) {
    // Si on a les bytes de l'image, on affiche l'objet qui est en mémoire.
    if (tuple != null && tuple.item2 != null && tuple.item2!.isNotEmpty) {
      final Uint8List imageBytes = tuple.item2!;

      return Image.memory(
        imageBytes,
        fit: fit,
      );
    }

    // Si on a l'adresse URL de l'image, on affiche une image du réseau.
    if (tuple != null && tuple.item1 != null && tuple.item1!.isNotEmpty) {
      final String imageUrl = tuple.item1!;

      return Image.network(
        imageUrl,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: LoadingRotating.square(),
            );
          }
        },
      );
    }

    // Si on a ni l'url de l'image, ni les bytes, on affiche rien.
    return Container();
  }

  void _onDelete() {
    vlImage.value = const Tuple2(null, null);
    if (onDeleted != null) {
      onDeleted!();
    }
  }

  void _onPress() {
    FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: allowedExtensions)
        .then((FilePickerResult? result) {
      if (result != null) {
        final Uint8List? fileBytes = result.files.first.bytes;
        final String fileName = result.files.first.name;
        final StorageFile storageFile = StorageFile(
          fileBytes: fileBytes,
          fileName: fileName,
        );
        onSaved(storageFile);
        vlImage.value = Tuple2(null, fileBytes);
      }
    });
  }
}
