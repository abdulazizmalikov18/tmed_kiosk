// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rec_specialist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecSpecialistModel _$RecSpecialistModelFromJson(Map<String, dynamic> json) =>
    RecSpecialistModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      lastname: json['lastname'] as String? ?? "",
      org: json['org'] as String? ?? "",
      job: json['job'] as String? ?? "",
    );

Map<String, dynamic> _$RecSpecialistModelToJson(RecSpecialistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastname': instance.lastname,
      'org': instance.org,
      'job': instance.job,
    };
