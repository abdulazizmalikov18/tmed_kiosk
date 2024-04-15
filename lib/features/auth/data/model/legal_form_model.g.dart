// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegalFormModel _$LegalFormModelFromJson(Map<String, dynamic> json) =>
    LegalFormModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      short: json['short'] as String? ?? '',
    );

Map<String, dynamic> _$LegalFormModelToJson(LegalFormModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'short': instance.short,
      'description': instance.description,
    };
