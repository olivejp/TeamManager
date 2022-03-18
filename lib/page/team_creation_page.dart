import 'package:flutter/material.dart';
import 'package:team_manager/component/team_creation_widget.dart';
import 'package:team_manager/component/team_list_widget.dart';

class TeamCreationPage extends StatelessWidget {
  const TeamCreationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Manager'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TeamateCreationWidget(),
          const TeamateListWidget(),
        ],
      ),
    );
  }
}
