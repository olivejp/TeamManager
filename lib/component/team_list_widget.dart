import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/domain/teamate.dart';
import 'package:team_manager/notifier/teamate_creation_notifier.dart';

class TeamateListWidget extends StatelessWidget {
  const TeamateListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TeamateCreationNotifier notifier = Provider.of<TeamateCreationNotifier>(context);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: context.watch<TeamateCreationNotifier>().listTeamate.length,
        itemBuilder: (context, index) => TeamateTile(teamate: notifier.listTeamate.elementAt(index)));
  }
}

class TeamateTile extends StatelessWidget {
  final Teamate teamate;

  const TeamateTile({Key? key, required this.teamate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => context.go('/resources/update/' + teamate.id.toString()),
        title: Text((teamate.nom ?? '') + ' ' + (teamate.prenom ?? '')),
        trailing: IconButton(
          onPressed: () {
            if (teamate.id != null) {
              context.read<TeamateCreationNotifier>().delete(teamate.id!);
            }
          },
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
