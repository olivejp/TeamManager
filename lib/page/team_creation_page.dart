import 'package:flutter/material.dart';
import 'package:team_manager/component/team_list_widget.dart';
import 'package:team_manager/component/team_visualization_widget.dart';

class TeamVisualizationPage extends StatelessWidget {
  const TeamVisualizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TeamateListWidget(),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: TeammateDetailWidget(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
