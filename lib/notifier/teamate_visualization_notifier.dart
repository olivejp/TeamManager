import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../domain/teamate.dart';
import '../service/service_teamate.dart';

class TeamateVisualizeNotifier extends ChangeNotifier {
  ServiceTeamate service = GetIt.I.get<ServiceTeamate>();

  Teamate? teamateToVisualize;

  TeamateVisualizeNotifier();

  Future<List<Teamate>> getListTeamate() {
    return service.getAll(jsonRoot: ['_embedded', 'teamate'], queryParams: {'sort': 'id asc'});
  }

  Future<void> delete(int id) {
    return service.delete(id).then((value) =>  notifyListeners());
  }

  void setNewTeamateToVisualize(int? idTeamate) {
    if (idTeamate != null) {
      service.read(idTeamate).then((teamateRead) {
        teamateToVisualize = teamateRead;
        notifyListeners();
      });
    } else {
      teamateToVisualize = null;
      notifyListeners();
    }
  }
}
