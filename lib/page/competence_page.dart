import 'package:flutter/material.dart';
import 'package:team_manager/component/competence_creation_widget.dart';
import 'package:team_manager/component/competence_list_widget.dart';

class CompetencePage extends StatelessWidget {
  const CompetencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compétence'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CompetenceCreationWidget(),
          const CompetenceListWidget(),
        ],
      ),
    );
  }
}
