import 'package:flutter/material.dart';
import 'package:team_manager/component/team_update_widget.dart';

class TeamUpdatePage extends StatelessWidget {
  const TeamUpdatePage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TeamateUpdateWidget(),
    );
  }
}
