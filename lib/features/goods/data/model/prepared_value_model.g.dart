// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepared_value_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreparedValueModel _$PreparedValueModelFromJson(Map<String, dynamic> json) =>
    PreparedValueModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      value: json['value'] as String? ?? '',
      baseFeature: (json['base_feature'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PreparedValueModelToJson(PreparedValueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'base_feature': instance.baseFeature,
    };
