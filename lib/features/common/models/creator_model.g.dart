// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatorModel _$CreatorModelFromJson(Map<String, dynamic> json) => CreatorModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      org: json['org'] as String? ?? '',
      job: json['job'] as String? ?? '',
    );

Map<String, dynamic> _$CreatorModelToJson(CreatorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastname': instance.lastname,
      'org': instance.org,
      'job': instance.job,
    };
