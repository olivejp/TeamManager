import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:rxdart/rxdart.dart';
import 'package:team_manager/domain/storage_file.dart';

///
/// Classe permettant d'afficher une image.
/// On peut lui passer une ImageUrl (String?) ou un StorageFile?
/// Par défaut c'est l'ImageUrl qui prime et c'est celle là qu'on affichera.
/// Si l'ImageUrl est null, on affichera le StorageFile.
/// Sinon on affichera aucune image mais uniquement un background de la couleur primaire de l'application.
///
class StorageImageWidget extends StatelessWidget {
  const StorageImageWidget({
    Key? key,
    required this.onSaved,
    this.onDeleted,
    this.imageUrl,
    this.storageFile,
    this.allowedExtensions = defaultAllowedExtensions,
    this.radius = 50,
  }) : super(key: key);

  static const List<String> defaultAllowedExtensions = <String>['jpg', 'jpeg', 'png', 'gif'];

  final FormFieldSetter<StorageFile> onSaved;
  final void Function()? onDeleted;
  final List<String> allowedExtensions;
  final String? imageUrl;
  final StorageFile? storageFile;
  final double radius;

  @override
  Widget build(BuildContext context) {
    const Widget icon = Icon(
      Icons.add_photo_alternate,
      color: Colors.white,
    );

    final Color color = Theme.of(context).primaryColor;

    Widget? child;
    if (imageUrl != null) {
      child = CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(imageUrl!),
        backgroundColor: color,
        child: icon,
      );
    } else if (storageFile?.fileBytes != null) {
      child = CircleAvatar(
        radius: radius,
        backgroundImage: MemoryImage(storageFile!.fileBytes!),
        backgroundColor: color,
        child: icon,
      );
    } else {
      child = CircleAvatar(
        radius: radius,
        backgroundColor: color,
        child: icon,
      );
    }

    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () => onTap(),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: child,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            padding: const EdgeInsets.all(0),
            tooltip: 'Supprimer la photo',
            onPressed: () {
              if (onDeleted != null) {
                onDeleted!();
              }
            },
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }

  void onTap() {
    FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: allowedExtensions, withData: true)
        .then((FilePickerResult? result) {
      if (result != null) {
        final StorageFile storageFileResult = StorageFile();
        storageFileResult.fileBytes = result.files.first.bytes;
        storageFileResult.fileName = result.files.first.name;
        onSaved(storageFileResult);
      }
    });
  }
}