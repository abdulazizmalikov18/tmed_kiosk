// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeatureModel _$FeatureModelFromJson(Map<String, dynamic> json) => FeatureModel(
      name: json['name'] as String? ?? '',
      id: json['id'] as int? ?? 0,
      requiredFormat: json['required_format'] as int? ?? 0,
      multiValues: json['multi_values'] as bool? ?? false,
      required: json['required'] as bool? ?? false,
    );

Map<String, dynamic> _$FeatureModelToJson(FeatureModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'required_format': instance.requiredFormat,
      'multi_values': instance.multiValues,
      'required': instance.required,
      'name': instance.name,
    };
