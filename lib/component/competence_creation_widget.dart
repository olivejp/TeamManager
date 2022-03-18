import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/notifier/competence_creation_notifier.dart';

class CompetenceCreationWidget extends StatelessWidget {
  CompetenceCreationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CompetenceCreationNotifier notifier = Provider.of<CompetenceCreationNotifier>(context, listen: false);
    final TextEditingController nomController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    void onSuccess(String message) {
      print('OnSuccess has been called');
      notifier.reset(nomController);
    }

    void onFailure(String message) {
      print('OnFailure has been called');
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(message),
        ),
      );
    }

    void save() {
      print('Save has been called');
      if (_formKey.currentState?.validate() == true) {
        notifier
            .create(_formKey)
            .then((value) => onSuccess('OK'))
            .onError((error, stackTrace) => onFailure(error.toString()));
      } else {
        print('Le formulaire est invalide.');
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
                style: GoogleFonts.roboto(fontSize: 15),
                onChanged: notifier.setNom,
                decoration: InputDecoration(
                  hintText: 'Nom',
                  hintStyle: GoogleFonts.roboto(fontSize: 15),
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
