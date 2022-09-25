import 'package:team_manager/openapi/api.dart';

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Conges {
  Conges({
    required this.dateDebut,
    required this.dateFin,
    required this.resources,
    required this.typeConges,
    this.commentaire,
    this.id,
  });

  int? id;
  DateTime dateDebut;
  DateTime dateFin;
  CongesCreateDtoTypeCongesEnum? typeConges;
  String? commentaire;
  List<Object> resources;
}
