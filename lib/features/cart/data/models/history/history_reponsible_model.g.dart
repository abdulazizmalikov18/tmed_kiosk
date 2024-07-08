// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_reponsible_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryResponsibleModel _$HistoryResponsibleModelFromJson(
        Map<String, dynamic> json) =>
    HistoryResponsibleModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      org: json['org'] as String? ?? '',
      job: json['job'] as String? ?? '',
    );

Map<String, dynamic> _$HistoryResponsibleModelToJson(
        HistoryResponsibleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastname': instance.lastname,
      'org': instance.org,
      'job': instance.job,
    };
