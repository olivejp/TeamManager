import 'package:json_annotation/json_annotation.dart';

import 'abstract.domain.dart';

part 'competence.g.dart';

@JsonSerializable()
class Competence extends AbstractDomain<int> {
  Competence({this.nom});

  String? nom;

  factory Competence.fromJson(Map<String, dynamic> json) =>
      _$CompetenceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CompetenceToJson(this);

  @override
  int? getId() {
    return id;
  }

  @override
  AbstractDomain<int> fromJson(Map<String, dynamic> map) {
    return Competence.fromJson(map);
  }
}
