import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/component/download_file.dart';
import 'package:team_manager/component/photo_storage.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/domain/document.dart';
import 'package:team_manager/notifier/teamate_refresh_notifier.dart';
import 'package:team_manager/notifier/teamate_visualization_notifier.dart';

import '../domain/teamate.dart';
import 'download_file_widget.dart';

class TeamateDetailWidget extends StatelessWidget {
  TeamateDetailWidget({Key? key}) : super(key: key);

  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void save(BuildContext context, TeamateVisualizeNotifier notifier) {
    notifier.checkAndSave(_formKey).then((teamateSaved) {
      context.read<TeamateRefreshNotifier>().refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    const double defaultWidth = 250;
    const double defaultHeight = 100;
    const acceptedExtensions = ['jpeg', 'jpg', 'pdf'];

    return Consumer<TeamateVisualizeNotifier>(
      builder: (context, notifier, child) {
        if (notifier.teamateToVisualize != null) {
          initializeControllers(notifier.teamateToVisualize!, dateFormat);
        } else {
          return Container();
        }

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Constants.backgroundColor,
            borderRadius: Constants.borderRadius,
          ),
          child: FocusTraversalGroup(
            policy: OrderedTraversalPolicy(),
            child: Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (notifier.isCreationMode)
                      ? Container()
                      : PhotoStorageWidget(
                          imageUrl: notifier.teamateToVisualize?.photoUrl,
                          onSaved: (storageFile) => notifier.setPhotoUrl(storageFile.fileBytes, storageFile.fileName!),
                          onDeleted: () => notifier.deletePhotoUrl(),
                          allowedExtensions: const ['jpeg', 'jpg', 'gif', 'png'],
                          borderRadius: Constants.borderRadius,
                          emptyColor: Constants.secondaryColor,
                          fit: BoxFit.cover,
                          isReadOnly: notifier.isReadOnly,
                        ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                notifier.isCreationMode
                                    ? "create_title".i18n()
                                    : notifier.isReadOnly
                                        ? "visualize_title".i18n()
                                        : "update_title".i18n(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              notifier.isReadOnly
                                  ? IconButton(
                                      tooltip: 'update'.i18n(),
                                      onPressed: notifier.changeReadOnly,
                                      icon: const Icon(Icons.create),
                                    )
                                  : Row(
                                      children: [
                                        IconButton(
                                          tooltip: "cancel".i18n(),
                                          onPressed: notifier.changeReadOnly,
                                          icon: const Icon(Icons.cancel_rounded),
                                        ),
                                        IconButton(
                                          tooltip: "save".i18n(),
                                          onPressed: () => save(context, notifier),
                                          icon: const Icon(Icons.save_alt_rounded),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                          TextFormField(
                            maxLength: 255,
                            readOnly: notifier.isReadOnly,
                            onChanged: notifier.setLastname,
                            controller: lastnameController,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(color: notifier.isReadOnly ? Colors.grey : Colors.white),
                            decoration: InputDecoration(
                              label: Text('lastname'.i18n()),
                              labelStyle: Theme.of(context).textTheme.caption,
                              counterStyle: Theme.of(context).textTheme.caption,
                            ),
                            validator: (String? value) {
                              return (value == null || value.isEmpty) ? 'Le nom est obligatoire' : null;
                            },
                            onFieldSubmitted: (value) {
                              notifier.setLastname(value);
                              save(context, notifier);
                            },
                          ),
                          TextFormField(
                            maxLength: 255,
                            readOnly: notifier.isReadOnly,
                            onChanged: notifier.setFirstname,
                            controller: firstnameController,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(color: notifier.isReadOnly ? Colors.grey : Colors.white),
                            decoration: InputDecoration(
                              label: Text('firstname'.i18n()),
                              labelStyle: Theme.of(context).textTheme.caption,
                              counterStyle: Theme.of(context).textTheme.caption,
                            ),
                            validator: (String? value) {
                              return (value == null || value.isEmpty) ? 'Le prénom est obligatoire' : null;
                            },
                            onFieldSubmitted: (value) {
                              notifier.setFirstname(value);
                              save(context, notifier);
                            },
                          ),
                          DateTimeField(
                            initialValue: notifier.teamateToVisualize?.dateNaissance,
                            onChanged: notifier.setBirthdate,
                            resetIcon: notifier.isReadOnly
                                ? null
                                : const Icon(
                                    Icons.delete_rounded,
                                    color: Colors.white,
                                  ),
                            readOnly: notifier.isReadOnly,
                            controller: birthdateController,
                            format: dateFormat,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(color: notifier.isReadOnly ? Colors.grey : Colors.white),
                            decoration: InputDecoration(
                              label: Text("birth_date".i18n()),
                              labelStyle: Theme.of(context).textTheme.caption,
                            ),
                            onFieldSubmitted: (value) {
                              notifier.setBirthdate(value);
                              save(context, notifier);
                            },
                            onShowPicker: (context, currentValue) {
                              if (!notifier.isReadOnly) {
                                return showDatePicker(
                                  context: context,
                                  helpText: "choose-birthdate".i18n(),
                                  confirmText: "choose".i18n(),
                                  cancelText: "cancel".i18n(),
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                              }
                              return Future.value();
                            },
                            validator: (DateTime? value) {
                              if (value == null) {
                                return 'La date de naissance est obligatoire.';
                              }
                              if (value.isAfter(DateTime.now())) {
                                return 'La date de naissance ne peut être après la date du jour.';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: TextFormField(
                              minLines: 6,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              maxLength: 2000,
                              readOnly: notifier.isReadOnly,
                              onChanged: notifier.setDescription,
                              controller: descriptionController,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: notifier.isReadOnly ? Colors.grey : Colors.white),
                              decoration: InputDecoration(
                                label: Text('description'.i18n()),
                                labelStyle: Theme.of(context).textTheme.caption,
                                counterStyle: Theme.of(context).textTheme.caption,
                                border: const OutlineInputBorder()
                              ),
                              onFieldSubmitted: (value) {
                                notifier.setDescription(value);
                                save(context, notifier);
                              },
                            ),
                          ),
                          if (!notifier.isCreationMode)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Documents",
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                          if (notifier.teamateToVisualize?.id != null)
                            Column(children: [
                              DownloadFileWidget(
                                isReadOnly: notifier.isReadOnly,
                                onUploadComplete: notifier.addDocument,
                                width: double.infinity,
                                height: defaultHeight,
                                acceptedMimeTypes: acceptedExtensions.map((e) => mimeFromExtension(e) ?? '').toList(),
                                path: notifier.teamateToVisualize!.id!.toString() + '/documents/',
                                buttonLabel: 'Télécharger un fichier',
                                label: 'Déposez ici vos documents',
                                acceptedExtensions: acceptedExtensions,
                              ),
                              Builder(builder: (context) {
                                final List<Document>? listDoc =
                                    context.select<TeamateVisualizeNotifier, List<Document>?>(
                                        (value) => value.teamateToVisualize?.listDocument);

                                if (listDoc != null && listDoc.isNotEmpty) {
                                  return Wrap(
                                      alignment: WrapAlignment.start,
                                      spacing: 16,
                                      runSpacing: 16,
                                      direction: Axis.horizontal,
                                      children: listDoc
                                          .map((doc) => Container(
                                                width: defaultWidth,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    style: BorderStyle.solid,
                                                  ),
                                                  color: Constants.backgroundColor,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: DownloadFile(
                                                  downloadUrl: doc.url!,
                                                  filename: doc.filename!,
                                                  displayDeleteButton: !notifier.isReadOnly,
                                                  onDelete: () => notifier.deleteDocument(doc),
                                                ),
                                              ))
                                          .toList());
                                } else {
                                  return Container();
                                }
                              }),
                            ])
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void initializeControllers(Teamate teammate, DateFormat format) {
    lastnameController.text = teammate.nom ?? '';
    firstnameController.text = teammate.prenom ?? '';
    descriptionController.text = teammate.description ?? '';
    birthdateController.text = (teammate.dateNaissance?.toString() != null) ? format.format(teammate.dateNaissance!) : '';
  }
}
