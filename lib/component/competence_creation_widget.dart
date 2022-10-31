import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/notifier/competence_creation_notifier.dart';

class CompetenceCreationWidget extends StatelessWidget {
  const CompetenceCreationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CompetenceCreationNotifier notifier = Provider.of<CompetenceCreationNotifier>(context, listen: false);
    final TextEditingController nomController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    void onSuccess(String message) {
      notifier.reset(nomController);
    }

    void onFailure(String message) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(message),
        ),
      );
    }

    void save() {
      if (_formKey.currentState?.validate() == true) {
        notifier
            .create(_formKey)
            .then((value) => onSuccess('OK'))
            .onError((error, stackTrace) => onFailure(error.toString()));
      }
    }

    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
                maxLength: 255,
                controller: nomController,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                onChanged: notifier.setNom,
                decoration: InputDecoration(
                  label: Text('name'.i18n()),
                  labelStyle: Theme.of(context).textTheme.bodySmall,
                  counterStyle: Theme.of(context).textTheme.bodySmall,
                ),
                validator: (String? value) {
                  return (value == null || value.isEmpty) ? 'Le nom est obligatoire' : null;
                }),
            OutlinedButton(
              onPressed: save,
              child: Text(
                'Ajouter',
                style: GoogleFonts.comfortaa(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
