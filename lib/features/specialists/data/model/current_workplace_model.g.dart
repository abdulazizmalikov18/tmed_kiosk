// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_workplace_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWorkplaceModel _$CurrentWorkplaceModelFromJson(
        Map<String, dynamic> json) =>
    CurrentWorkplaceModel(
      id: json['id'] as int? ?? 0,
      createDate: json['create_date'] as String? ?? '',
      type: json['type'] == null
          ? const SpecCatEntity()
          : const SpecCatConverter()
              .fromJson(json['type'] as Map<String, dynamic>?),
      updateDate: json['update_date'] as String? ?? '',
      value: json['value'] as String? ?? '',
    );

Map<String, dynamic> _$CurrentWorkplaceModelToJson(
        CurrentWorkplaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': const SpecCatConverter().toJson(instance.type),
      'value': instance.value,
      'create_date': instance.createDate,
      'update_date': instance.updateDate,
    };
