import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/notifier/teamate_refresh_notifier.dart';
import 'package:team_manager/notifier/teamate_visualization_notifier.dart';

import '../domain/teamate.dart';

class TeamateDetailWidget extends StatelessWidget {
  TeamateDetailWidget({Key? key}) : super(key: key);

  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void save(BuildContext context, TeamateVisualizeNotifier notifier) {
    notifier.checkAndSave(_formKey).then((value) {
      context.read<TeamateRefreshNotifier>().refresh();
      notifier.changeToCreationMode();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  (notifier.isCreationMode) ? Container() : Container(
                      width: 200,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Constants.secondaryColor,
                        borderRadius: Constants.borderRadius,
                      ),
                      child: notifier.isReadOnly
                          ? Container()
                          : Center(
                              child: IconButton(
                                onPressed: () {
                                  FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['jpg', 'png', 'gif']).then((FilePickerResult? result) {
                                    if (result != null) {
                                      notifier.setPhotoUrl(result.files.first.bytes, result.files.first.name);
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                              ),
                            ),
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
                                  : IconButton(
                                      tooltip: "save".i18n(),
                                      onPressed: () => save(context, notifier),
                                      icon: const Icon(Icons.save_alt_rounded),
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
                                  locale: const Locale("fr", "FR"),
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

  void initializeControllers(Teamate teamate, DateFormat format) {
    lastnameController.text = teamate.nom ?? '';
    firstnameController.text = teamate.prenom ?? '';
    birthdateController.text = (teamate.dateNaissance?.toString() != null) ? format.format(teamate.dateNaissance!) : '';
  }
}
