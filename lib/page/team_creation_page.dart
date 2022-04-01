import 'package:flutter/material.dart';
import 'package:team_manager/component/team_list_widget.dart';
import 'package:team_manager/component/team_visualization_widget.dart';

class TeamVisualizationPage extends StatelessWidget {
  const TeamVisualizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              flex: 1,
              child: TeamateListWidget(),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: TeamateDetailWidget(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
