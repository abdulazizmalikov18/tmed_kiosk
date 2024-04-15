// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'a_region_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARegionModel _$ARegionModelFromJson(Map<String, dynamic> json) => ARegionModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      type: json['type'] ?? 0,
      userCount: json['user_count'] as int? ?? 0,
      parent: json['parent'] as int? ?? 0,
    );

Map<String, dynamic> _$ARegionModelToJson(ARegionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'type': instance.type,
      'user_count': instance.userCount,
      'parent': instance.parent,
    };
