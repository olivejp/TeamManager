import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/notifier/teamate_creation_notifier.dart';

class TeamateCreationWidget extends StatelessWidget {
  TeamateCreationWidget({Key? key}) : super(key: key);

  StreamSubscription? streamSubscription;

  @override
  Widget build(BuildContext context) {
    print('Rebuilding...');
    final TeamateCreationNotifier notifier = Provider.of<TeamateCreationNotifier>(context, listen: false);
    final TextEditingController nomController = TextEditingController();
    final TextEditingController prenomController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    void onSuccess(String message) {
      print('OnSuccess has been called');
      notifier.reset(nomController, prenomController);
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
            TextFormField(
                maxLength: 255,
                controller: prenomController,
                style: GoogleFonts.roboto(fontSize: 15),
                onChanged: notifier.setPrenom,
                decoration: InputDecoration(
                  hintText: 'Prénom',
                  hintStyle: GoogleFonts.roboto(fontSize: 15),
                ),
                validator: (String? value) {
                  return (value == null || value.isEmpty) ? 'Le prénom est obligatoire' : null;
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
