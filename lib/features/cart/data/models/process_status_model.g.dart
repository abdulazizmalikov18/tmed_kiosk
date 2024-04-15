// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessStatusModel _$ProcessStatusModelFromJson(Map<String, dynamic> json) =>
    ProcessStatusModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      flow: json['flow'] as int? ?? 0,
      key: json['key'] as String? ?? '',
      order: json['order'] as int? ?? 0,
      isVisible: json['is_visible'] as bool? ?? false,
      isDefault: json['is_default'] as bool? ?? false,
      productCount: json['product_count'] as int? ?? 0,
    );

Map<String, dynamic> _$ProcessStatusModelToJson(ProcessStatusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'flow': instance.flow,
      'key': instance.key,
      'order': instance.order,
      'is_visible': instance.isVisible,
      'is_default': instance.isDefault,
      'product_count': instance.productCount,
    };
