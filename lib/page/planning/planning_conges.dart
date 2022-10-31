import 'package:team_manager/openapi/api.dart';

class Conges {
  Conges({
    this.id,
    required this.dateDebut,
    required this.dateFin,
    required this.typeConges,
    required this.portionDebut,
    required this.portionFin,
    required this.resources,
    this.commentaire,
  });

  int? id;
  DateTime dateDebut;
  DateTime dateFin;
  CongesPersistDtoTypeCongesEnum typeConges;
  String portionDebut;
  String portionFin;
  List<Object> resources;
  String? commentaire;
}
