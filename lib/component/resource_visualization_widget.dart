import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/component/photo_storage.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/notifier/teamate_refresh_notifier.dart';
import 'package:team_manager/notifier/teamate_visualization_notifier.dart';
import 'package:team_manager/openapi/api.dart';

import 'download_file_widget.dart';

class ResourceDetailWidget extends StatelessWidget {
  ResourceDetailWidget({Key? key}) : super(key: key);

  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final MaskTextInputFormatter dateMaskFormatter =
      MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  void save(BuildContext context, TeamateVisualizeNotifier notifier) {
    notifier.checkAndSave(_formKey).then((teammateSaved) {
      context.read<TeamateRefreshNotifier>().refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    const double defaultHeight = 100;
    const acceptedDocumentExtensions = ['jpeg', 'jpg', 'pdf'];
    const acceptedPhotoExtensions = ['jpeg', 'jpg', 'gif', 'png'];

    return Consumer<TeamateVisualizeNotifier>(
      builder: (context, notifier, child) {
        if (notifier.teammateToVisualize != null) {
          initializeControllers(notifier.teammateToVisualize!, dateFormat);
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
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        if (notifier.isReadOnly)
                          IconButton(
                            tooltip: 'update'.i18n(),
                            onPressed: notifier.changeReadOnly,
                            icon: const Icon(Icons.create),
                          )
                      ],
                    ),
                    PhotoStorageWidget(
                      width: 150,
                      height: 150,
                      imageBase64: notifier.teammateToVisualize?.photo,
                      onSaved: notifier.setPhotoUrl,
                      onDeleted: notifier.deletePhotoUrl,
                      allowedExtensions: acceptedPhotoExtensions,
                      borderRadius: BorderRadius.circular(100),
                      emptyColor: Constants.secondaryColor,
                      fit: BoxFit.cover,
                      isReadOnly: notifier.isReadOnly,
                    ),
                    TextFormField(
                      maxLength: 255,
                      readOnly: notifier.isReadOnly,
                      onChanged: notifier.setLastname,
                      controller: lastnameController,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: notifier.isReadOnly ? Colors.grey : Colors.white),
                      decoration: InputDecoration(
                        label: Text('lastname'.i18n()),
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        counterStyle: Theme.of(context).textTheme.bodySmall,
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
                          .bodyMedium
                          ?.copyWith(color: notifier.isReadOnly ? Colors.grey : Colors.white),
                      decoration: InputDecoration(
                        label: Text('firstname'.i18n()),
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        counterStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                      validator: (String? value) {
                        return (value == null || value.isEmpty) ? 'Le prénom est obligatoire' : null;
                      },
                      onFieldSubmitted: (value) {
                        notifier.setFirstname(value);
                        save(context, notifier);
                      },
                    ),
                    TextFormField(
                      maxLength: 255,
                      readOnly: notifier.isReadOnly,
                      onChanged: notifier.setEmail,
                      controller: emailController,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: notifier.isReadOnly ? Colors.grey : Colors.white),
                      decoration: InputDecoration(
                        label: Text('email'.i18n()),
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        counterStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                      validator: (String? value) {
                        return (value == null || value.isEmpty) ? 'L\'email est obligatoire' : null;
                      },
                      onFieldSubmitted: (value) {
                        notifier.setEmail(value);
                        save(context, notifier);
                      },
                    ),
                    TextFormField(
                      controller: birthdateController,
                      onChanged: notifier.setBirthdateAsString,
                      inputFormatters: [dateMaskFormatter],
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: notifier.isReadOnly ? Colors.grey : Colors.white),
                      decoration: InputDecoration(
                        label: Text("birth_date".i18n()),
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (notifier.isReadOnly) {
                              return;
                            }
                            showDatePicker(
                                    context: context,
                                    initialDate: (notifier.teammateToVisualize?.dateNaissance != null)
                                        ? dateFormat.parse(notifier.teammateToVisualize!.dateNaissance!)
                                        : DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100))
                                .then((value) {
                              notifier.setBirthdate(value, birthdateController);
                            });
                          },
                          icon: const Icon(Icons.calendar_today),
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null) {
                          return 'Champ obligatoire.';
                        }
                        try {
                          notifier.stringToDate(value);
                        } catch (e) {
                          return 'La date de naissance est mal formatée.';
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
                            .bodyMedium
                            ?.copyWith(color: notifier.isReadOnly ? Colors.grey : Colors.white),
                        decoration: InputDecoration(
                            label: Text('description'.i18n()),
                            labelStyle: Theme.of(context).textTheme.bodySmall,
                            counterStyle: Theme.of(context).textTheme.bodySmall,
                            border: const OutlineInputBorder()),
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
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    Column(children: [
                      DownloadFileWidget(
                        radius: Constants.borderRadius,
                        isReadOnly: notifier.isReadOnly,
                        onUploadComplete: notifier.addDocument,
                        width: double.infinity,
                        height: defaultHeight,
                        acceptedMimeTypes: acceptedDocumentExtensions.map((e) => mimeFromExtension(e) ?? '').toList(),
                        path: notifier.teammateToVisualize?.id?.toString() ?? '/documents/',
                        buttonLabel: 'Télécharger un fichier',
                        label: 'Déposez ici vos documents',
                        acceptedExtensions: acceptedDocumentExtensions,
                      ),
                      if (!notifier.isReadOnly)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: notifier.changeReadOnly,
                              icon: const Icon(Icons.cancel_rounded),
                              label: Text(
                                "cancel".i18n(),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () => save(context, notifier),
                              icon: const Icon(Icons.save_alt_rounded),
                              label: Text(
                                "save".i18n(),
                              ),
                            ),
                          ],
                        ),
                    ])
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void initializeControllers(TeammateDto teammate, DateFormat format) {
    lastnameController.text = teammate.nom ?? '';
    firstnameController.text = teammate.prenom ?? '';
    descriptionController.text = teammate.description ?? '';
    emailController.text = teammate.email ?? '';
    birthdateController.text = (teammate.dateNaissance != null) ? teammate.dateNaissance! : '';
  }
}
