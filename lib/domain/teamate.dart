import 'package:json_annotation/json_annotation.dart';

import 'abstract.domain.dart';
import 'competence.dart';

part 'teamate.g.dart';

@JsonSerializable()
class Teamate extends AbstractDomain<int> {
  Teamate({this.nom, this.prenom});

  String? nom;
  String? prenom;
  DateTime? dateNaissance;
  String? photoUrl;
  List<Competence>? listCompetence;

  factory Teamate.fromJson(Map<String, dynamic> json) =>
      _$TeamateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TeamateToJson(this);

  @override
  int? getId() {
    return id;
  }

  @override
  AbstractDomain<int> fromJson(Map<String, dynamic> map) {
    return Teamate.fromJson(map);
  }
}
