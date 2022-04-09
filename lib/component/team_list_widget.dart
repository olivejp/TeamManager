import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/domain/teamate.dart';
import 'package:team_manager/notifier/teamate_refresh_notifier.dart';
import 'package:team_manager/notifier/teamate_visualization_notifier.dart';

import '../domain/view_dialog_action.dart';

class TeamateListWidget extends StatelessWidget {
  const TeamateListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff454457),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Liste des ressources',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  IconButton(
                    tooltip: "add".i18n(),
                    onPressed: () => context.read<TeamateVisualizeNotifier>().changeToCreationMode(),
                    icon: const Icon(Icons.add),
                  )
                ],
              ),
            ),
          ),
          Consumer<TeamateRefreshNotifier>(
            builder: (_, value, __) => FutureBuilder<List<Teamate>>(
              future: context.read<TeamateVisualizeNotifier>().getListTeamate(),
              builder: (context, snapshotListTeamate) {
                if (snapshotListTeamate.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshotListTeamate.data!.length,
                    itemBuilder: (context, index) => TeamateTile(
                      teamate: snapshotListTeamate.data!.elementAt(index),
                    ),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TeamateTile extends StatelessWidget {
  final Teamate teamate;

  const TeamateTile({Key? key, required this.teamate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (teamate.id != null) {
          context.read<TeamateVisualizeNotifier>().setNewTeamateToVisualize(teamate.id);
        }
      },
      title: Text((teamate.nom ?? '') + ' ' + (teamate.prenom ?? '')),
      trailing: IconButton(
        tooltip: 'delete'.i18n(),
        onPressed: () async {
          final action = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text('delete_teamate'.i18n()),
              actions: [
                TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(ViewDialogsAction.yes),
                  icon: const Icon(Icons.check_rounded),
                  label: Text('yes'.i18n()),
                ),
                TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(ViewDialogsAction.no),
                  icon: const Icon(Icons.cancel_rounded),
                  label: Text('no'.i18n()),
                ),
              ],
            ),
          );

          if (action == ViewDialogsAction.yes) {
            if (teamate.id != null) {
              context.read<TeamateVisualizeNotifier>().delete(teamate.id!).then((value) {
                context.read<TeamateRefreshNotifier>().refresh();
                context.read<TeamateVisualizeNotifier>().changeToCreationMode();
              });
            }
          }
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }
}
