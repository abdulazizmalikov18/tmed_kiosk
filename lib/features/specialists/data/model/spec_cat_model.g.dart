// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spec_cat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecCatModel _$SpecCatModelFromJson(Map<String, dynamic> json) => SpecCatModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      specialistCount: json['specialist_count'] as int? ?? 0,
    );

Map<String, dynamic> _$SpecCatModelToJson(SpecCatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'specialist_count': instance.specialistCount,
    };
