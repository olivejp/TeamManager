import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/domain/teamate.dart';
import 'package:team_manager/notifier/teamate_refresh_notifier.dart';
import 'package:team_manager/notifier/teamate_visualization_notifier.dart';
import 'package:team_manager/page/team_creation_page.dart';

import '../domain/view_dialog_action.dart';

class TeamateListWidget extends StatelessWidget {
  const TeamateListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Constants.backgroundColor,
        borderRadius: Constants.borderRadius,
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: Constants.borderRadius,
              color: Constants.secondaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 6,
                    child: Text(
                      'Liste des ressources',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
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
              builder: (_, snapshotListTeamate) {
                if (snapshotListTeamate.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshotListTeamate.data!.length,
                    itemBuilder: (_, index) => TeamateTile(
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
                borderRadius: Constants.borderRadius,
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
