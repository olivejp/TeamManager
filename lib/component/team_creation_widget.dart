import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/notifier/teamate_creation_notifier.dart';

class TeamateCreationWidget extends StatelessWidget {
  const TeamateCreationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TeamateCreationNotifier notifier = Provider.of<TeamateCreationNotifier>(context, listen: false);
    final TextEditingController nomController = TextEditingController();
    final TextEditingController prenomController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    void onSuccess(String message) {
      notifier.reset(nomController, prenomController);
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
      } else {
        print('Le formulaire est invalide.');
      }
    }

    return Consumer<TeamateCreationNotifier>(
      builder: (context, notifier, child) {
        if (notifier.teamateToUpdate != null) {
          if (notifier.teamateToUpdate?.nom != null) {
            nomController.text = notifier.teamateToUpdate?.nom ?? '';
          }
          if (notifier.teamateToUpdate?.prenom != null) {
            prenomController.text = notifier.teamateToUpdate?.prenom ?? '';
          }
        }
        return child!;
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
                maxLength: 255,
                controller: nomController,
                style: Theme.of(context).textTheme.bodyText2,
                onChanged: notifier.setNom,
                decoration: InputDecoration(
                  hintText: 'Nom',
                  hintStyle: Theme.of(context).textTheme.bodyText2,
                ),
                validator: (String? value) {
                  return (value == null || value.isEmpty) ? 'Le nom est obligatoire' : null;
                }),
            TextFormField(
                maxLength: 255,
                controller: prenomController,
                style: Theme.of(context).textTheme.bodyText2,
                onChanged: notifier.setPrenom,
                decoration: InputDecoration(
                  hintText: 'Prénom',
                  hintStyle: Theme.of(context).textTheme.bodyText2,
                ),
                validator: (String? value) {
                  return (value == null || value.isEmpty) ? 'Le prénom est obligatoire' : null;
                }),
            OutlinedButton(
              onPressed: save,
              child: Text(
                'Ajouter',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
