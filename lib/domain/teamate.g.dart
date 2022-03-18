// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teamate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teamate _$TeamateFromJson(Map<String, dynamic> json) {
  return Teamate(
    nom: json['nom'] as String?,
    prenom: json['prenom'] as String?,
  )
    ..id = json['id'] as int?
    ..createDate = json['createDate']
    ..updateDate = json['updateDate']
    ..creatorUid = json['creatorUid'] as String?
    ..dateNaissance = json['dateNaissance'] == null
        ? null
        : DateTime.parse(json['dateNaissance'] as String)
    ..listCompetence = (json['listCompetence'] as List<dynamic>?)
        ?.map((e) => Competence.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$TeamateToJson(Teamate instance) => <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate,
      'updateDate': instance.updateDate,
      'creatorUid': instance.creatorUid,
      'nom': instance.nom,
      'prenom': instance.prenom,
      'dateNaissance': instance.dateNaissance?.toIso8601String(),
      'listCompetence': instance.listCompetence,
    };
