// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_work_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessWorkModel _$ProcessWorkModelFromJson(Map<String, dynamic> json) =>
    ProcessWorkModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      creator: json['creator'] as String? ?? '',
      org: json['org'] as String? ?? '',
      active: json['active'] as bool? ?? true,
    );

Map<String, dynamic> _$ProcessWorkModelToJson(ProcessWorkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'creator': instance.creator,
      'org': instance.org,
      'active': instance.active,
    };
