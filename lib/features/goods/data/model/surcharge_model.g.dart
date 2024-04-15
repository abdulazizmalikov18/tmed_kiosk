// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surcharge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurchargeModel _$SurchargeModelFromJson(Map<String, dynamic> json) =>
    SurchargeModel(
      id: json['id'] as int? ?? 0,
      org: json['org'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? false,
      type: json['type'] as int? ?? 0,
      value: (json['value'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$SurchargeModelToJson(SurchargeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'org': instance.org,
      'desc': instance.desc,
      'type': instance.type,
      'value': instance.value,
      'is_active': instance.isActive,
    };
