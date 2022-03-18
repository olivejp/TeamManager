import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/component/team_update_widget.dart';

import '../notifier/teamate_update_notifier.dart';

class TeamUpdatePage extends StatelessWidget {
  const TeamUpdatePage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TeamateUpdateNotifier(id),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update'),
        ),
        body: TeamateUpdateWidget(),
      ),
    );
  }
}
