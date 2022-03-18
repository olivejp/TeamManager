import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:team_manager/domain/teamate.dart';
import 'package:team_manager/service/service_competence.dart';
import 'package:team_manager/service/service_teamate.dart';

import '../domain/competence.dart';

class TeamateUpdateNotifier extends ChangeNotifier {
  final String id;
  final ServiceTeamate _serviceTeamate = GetIt.I.get();
  final CompetenceService competenceService = GetIt.I.get<CompetenceService>();
  Teamate? teamate;
  List<Competence> listCompetence = [];

  TeamateUpdateNotifier(this.id) {
    getAllCompetence().then(
      (_) => _serviceTeamate.read(int.parse(id)).then((value) {
        teamate = value;
        notifyListeners();
      }),
    );
  }

  setNom(String? newName) {
    teamate?.nom = newName;
  }

  setPrenom(String? newPrenom) {
    teamate?.prenom = newPrenom;
  }

  setDateNaissance(DateTime? newDateNaissance) {
    teamate?.dateNaissance = newDateNaissance;
  }

  setListCompetence(dynamic returnValue) {
    final List<dynamic> listCompetenceId = returnValue;
    final List<Competence> list =
        listCompetenceId.map((e) => listCompetence.firstWhere((element) => element.id == e)).toList();
    teamate?.listCompetence = list;
  }

  Future<void> update() {
    if (teamate != null) {
      return _serviceTeamate.update(teamate!);
    } else {
      return Future.error('No teammate in the update page.');
    }
  }

  Future<void> getAllCompetence() {
    return competenceService
        .getAll(jsonRoot: ['_embedded', 'competence'], queryParams: {'sort': 'id asc'}).then((value) {
      listCompetence = value;
    });
  }
}
