import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/notifier/teamate_visualization_notifier.dart';

class TeamateDetailWidget extends StatelessWidget {
  const TeamateDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nomController = TextEditingController();
    final TextEditingController prenomController = TextEditingController();
    final TextEditingController dateNaissanceController = TextEditingController();
    final DateFormat format = DateFormat("dd-MMM-yyyy");

    return Consumer<TeamateVisualizeNotifier>(
      builder: (context, notifier, child) {
        if (notifier.teamateToVisualize != null) {
          if (notifier.teamateToVisualize?.nom != null) {
            nomController.text = notifier.teamateToVisualize?.nom ?? '';
          }
          if (notifier.teamateToVisualize?.prenom != null) {
            prenomController.text = notifier.teamateToVisualize?.prenom ?? '';
          }

          String dateNaissanceFormatted = (notifier.teamateToVisualize?.dateNaissance?.toString() != null)
              ? format.format(notifier.teamateToVisualize!.dateNaissance!)
              : '';
          dateNaissanceController.text = dateNaissanceFormatted;

          return child!;
        }
        return Container();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xff454457),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: <Widget>[
            TextFormField(
              readOnly: true,
              controller: nomController,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                label: const Text('Nom'),
                labelStyle: Theme.of(context).textTheme.caption,
              ),
            ),
            TextFormField(
              readOnly: true,
              controller: prenomController,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                label: const Text('Prénom'),
                labelStyle: Theme.of(context).textTheme.caption,
              ),
            ),
            DateTimeField(
              resetIcon: null,
              readOnly: true,
              controller: dateNaissanceController,
              format: format,
              decoration: InputDecoration(
                label: const Text('Date de naissance'),
                labelStyle: Theme.of(context).textTheme.caption,
              ),
              onShowPicker: (BuildContext context, DateTime? currentValue) => Future.value(),
            ),
          ],
        ),
      ),
    );
  }
}
