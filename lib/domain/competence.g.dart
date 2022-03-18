// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Competence _$CompetenceFromJson(Map<String, dynamic> json) {
  return Competence(
    nom: json['nom'] as String?,
  )
    ..id = json['id'] as int?
    ..createDate = json['createDate']
    ..updateDate = json['updateDate']
    ..creatorUid = json['creatorUid'] as String?;
}

Map<String, dynamic> _$CompetenceToJson(Competence instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate,
      'updateDate': instance.updateDate,
      'creatorUid': instance.creatorUid,
      'nom': instance.nom,
    };
