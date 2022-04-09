import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
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
            color: const Color(0xff454457),
            borderRadius: BorderRadius.circular(15),
          ),
          child: FocusTraversalGroup(
            policy: OrderedTraversalPolicy(),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      notifier.isReadOnly
                          ? IconButton(
                              tooltip: 'update'.i18n(),
                              onPressed: notifier.changeReadOnly,
                              icon: const Icon(Icons.create),
                            )
                          : IconButton(
                              tooltip: "save".i18n(),
                              onPressed: () => notifier.save(_formKey).then((value) {
                                context.read<TeamateRefreshNotifier>().refresh();
                                notifier.changeToCreationMode();
                              }),
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
