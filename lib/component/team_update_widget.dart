import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/notifier/teamate_creation_notifier.dart';
import 'package:team_manager/notifier/teamate_update_notifier.dart';

import '../domain/competence.dart';

class TeamateUpdateWidget extends StatelessWidget {
  TeamateUpdateWidget({Key? key}) : super(key: key);

  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController dateNaissanceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TeamateCreationNotifier creationNotifier = Provider.of(context, listen: false);
    final TeamateUpdateNotifier notifier = Provider.of(context);
    final DateFormat format = DateFormat("dd-MM-yyyy");

    nomController.text = notifier.teamate?.nom ?? '';
    prenomController.text = notifier.teamate?.prenom ?? '';
    String dateNaissanceFormatted =
        (notifier.teamate?.dateNaissance?.toString() != null) ? format.format(notifier.teamate!.dateNaissance!) : '';
    dateNaissanceController.text = dateNaissanceFormatted;
    final dataSource = notifier.listCompetence.map((e) => {'nom': e.nom, 'id': e.id.toString()} as dynamic).toList();
    final List<Competence>? initialListCompetence = notifier.teamate?.listCompetence;

    void update() {
      notifier.update().then((value) {
        creationNotifier.refresh();
        GoRouter.of(context).pop();
      }).onError(
        (error, stackTrace) => showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            title: Text('Erreur lors de la sauvegarde.'),
          ),
        ),
      );
    }

    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
                maxLength: 255,
                controller: nomController,
                onChanged: notifier.setNom,
                style: GoogleFonts.roboto(fontSize: 15),
                decoration: InputDecoration(
                  label: Text('Nom'),
                  hintText: 'Nom',
                  hintStyle: GoogleFonts.roboto(fontSize: 15),
                ),
                validator: (String? value) {
                  return (value == null || value.isEmpty) ? 'Le nom est obligatoire' : null;
                }),
            TextFormField(
                maxLength: 255,
                controller: prenomController,
                onChanged: notifier.setPrenom,
                style: GoogleFonts.roboto(fontSize: 15),
                decoration: InputDecoration(
                  label: const Text('Prénom'),
                  hintText: 'Prénom',
                  hintStyle: GoogleFonts.roboto(fontSize: 15),
                ),
                validator: (String? value) {
                  return (value == null || value.isEmpty) ? 'Le prénom est obligatoire' : null;
                }),
            DateTimeField(
              controller: dateNaissanceController,
              onChanged: notifier.setDateNaissance,
              format: format,
              decoration: InputDecoration(
                label: const Text('Date de naissance'),
                hintText: 'Date de naissance',
                hintStyle: GoogleFonts.roboto(fontSize: 15),
              ),
              onShowPicker: (context, currentValue) => showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100),
              ),
            ),
            MultiSelectFormField(
              initialValue: initialListCompetence,
              chipBackGroundColor: Colors.red,
              checkBoxActiveColor: Colors.red,
              dialogShapeBorder: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              dataSource: dataSource,
              textField: 'nom',
              valueField: 'id',
              leading: Icon(Icons.bookmark),
              okButtonLabel: 'OK',
              cancelButtonLabel: 'Annuler',
              hintWidget: const Text('Choisissez les compétences'),
              title: const Text('Compétences'),
              onSaved: notifier.setListCompetence,
            ),
            OutlinedButton(
              onPressed: update,
              child: Text(
                'Mettre à jour',
                style: GoogleFonts.comfortaa(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
