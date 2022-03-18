import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/notifier/teamate_creation_notifier.dart';

import '../domain/competence.dart';
import '../notifier/competence_creation_notifier.dart';

class CompetenceListWidget extends StatelessWidget {
  const CompetenceListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CompetenceCreationNotifier notifier = Provider.of<CompetenceCreationNotifier>(context);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: context.watch<CompetenceCreationNotifier>().listCompetence.length,
        itemBuilder: (context, index) => CompetenceTile(competence: notifier.listCompetence.elementAt(index)));
  }
}

class CompetenceTile extends StatelessWidget {
  final Competence competence;

  const CompetenceTile({Key? key, required this.competence}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(competence.nom ?? ''),
        trailing: IconButton(
          onPressed: () {
            if (competence.id != null) {
              context.read<TeamateCreationNotifier>().delete(competence.id!);
            }
          },
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
