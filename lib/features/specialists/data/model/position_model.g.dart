// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionModel _$PositionModelFromJson(Map<String, dynamic> json) =>
    PositionModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      createDate: json['create_date'] as String? ?? '',
      name: json['name'] as String? ?? '',
      org: json['org'] == null
          ? const SpecCatEntity()
          : const SpecCatConverter()
              .fromJson(json['org'] as Map<String, dynamic>?),
      status: json['status'] as bool? ?? false,
      updateDate: json['update_date'] as String? ?? '',
    );

Map<String, dynamic> _$PositionModelToJson(PositionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'org': const SpecCatConverter().toJson(instance.org),
      'name': instance.name,
      'status': instance.status,
      'create_date': instance.createDate,
      'update_date': instance.updateDate,
    };
