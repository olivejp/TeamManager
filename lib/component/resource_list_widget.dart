import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/notifier/teamate_refresh_notifier.dart';
import 'package:team_manager/notifier/teamate_visualization_notifier.dart';
import 'package:team_manager/openapi/api.dart';
import 'package:team_manager/service/toast_service.dart';

import '../domain/view_dialog_action.dart';

class ResourceListWidget extends StatelessWidget {
  ResourceListWidget({Key? key}) : super(key: key);

  final ToastService serviceToast = GetIt.I.get();

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
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Row(children: [
                    IconButton(
                      tooltip: "filter".i18n(),
                      onPressed: () => showDialog(
                          builder: (contextDialog) {
                            return AlertDialog(
                              title: const Text('Trier la liste par'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      context.read<TeamateVisualizeNotifier>().changeSort('id');
                                      context.read<TeamateRefreshNotifier>().refresh();
                                      Navigator.of(contextDialog).pop();
                                    },
                                    child: const Text('Id')),
                                TextButton(
                                    onPressed: () {
                                      context.read<TeamateVisualizeNotifier>().changeSort('nom');
                                      context.read<TeamateRefreshNotifier>().refresh();
                                      Navigator.of(contextDialog).pop();
                                    },
                                    child: const Text('Nom')),
                                TextButton(
                                    onPressed: () {
                                      context.read<TeamateVisualizeNotifier>().changeSort('prenom');
                                      context.read<TeamateRefreshNotifier>().refresh();
                                      Navigator.of(contextDialog).pop();
                                    },
                                    child: const Text('Prénom')),
                              ],
                            );
                          },
                          context: context),
                      icon: const Icon(Icons.filter_list_rounded),
                    ),
                    IconButton(
                      tooltip: "add".i18n(),
                      onPressed: () => context.read<TeamateVisualizeNotifier>().changeToCreationMode(),
                      icon: const Icon(Icons.add),
                    ),
                  ]),
                ],
              ),
            ),
          ),
          Consumer<TeamateRefreshNotifier>(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Aucunes données à afficher'),
                    IconButton(
                      onPressed: () => context.read<TeamateRefreshNotifier>().refresh(),
                      icon: const Icon(Icons.refresh),
                    )
                  ],
                ),
              ),
            ),
            builder: (_, value, noDataChild) => FutureBuilder<List<TeammateDto>>(
              future: context.read<TeamateVisualizeNotifier>().getListTeamate(),
              builder: (_, snapshotListTeamate) {
                if (snapshotListTeamate.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshotListTeamate.connectionState == ConnectionState.done) {
                  if (snapshotListTeamate.hasData) {
                    var data = snapshotListTeamate.data;
                    if (data!.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshotListTeamate.data!.length,
                        itemBuilder: (_, index) {
                          return TeammateTile(teammate: snapshotListTeamate.data!.elementAt(index));
                        },
                      );
                    }
                  }
                }
                return noDataChild!;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TeammateTile extends StatelessWidget {
  final TeammateDto teammate;

  const TeammateTile({Key? key, required this.teammate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: context.select<TeamateVisualizeNotifier, int?>((value) => value.teammateToVisualize?.id) == teammate.id,
      onTap: () {
        if (teammate.id != null) {
          context.read<TeamateVisualizeNotifier>().setNewTeamateToVisualize(teammate.id);
        }
      },
      title: Text('${teammate.nom ?? ''} ${teammate.prenom ?? ''}'),
      leading: CircleAvatar(
        radius: 18,
        foregroundImage: teammate.photo != null ? MemoryImage(base64Decode(teammate!.photo!)) : null,
        backgroundColor: Theme.of(context).primaryColor,
        child: Text((teammate.nom?.substring(0, 1).toUpperCase() ?? "") +
            (teammate.prenom?.substring(0, 1).toUpperCase() ?? "")),
      ),
      trailing: IconButton(
        tooltip: 'delete'.i18n(),
        onPressed: () {
          showDialog(
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
          ).then((action) {
            if (action == ViewDialogsAction.yes) {
              if (teammate.id != null) {
                context.read<TeamateVisualizeNotifier>().delete(teammate.id!).then((value) {
                  context.read<TeamateRefreshNotifier>().refresh();
                  context.read<TeamateVisualizeNotifier>().changeToCreationMode();
                });
              }
            }
          });
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }
}
