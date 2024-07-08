// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatusModel _$OrderStatusModelFromJson(Map<String, dynamic> json) =>
    OrderStatusModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      flow: (json['flow'] as num?)?.toInt() ?? 0,
      key: json['key'] as String? ?? '',
      toFinish: json['to_finish'] as bool? ?? false,
      toCancel: json['to_cancel'] as bool? ?? false,
      isDefault: json['is_default'] as bool? ?? false,
      productCount: json['product_count'] ?? '',
    );

Map<String, dynamic> _$OrderStatusModelToJson(OrderStatusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'flow': instance.flow,
      'key': instance.key,
      'to_finish': instance.toFinish,
      'to_cancel': instance.toCancel,
      'is_default': instance.isDefault,
      'product_count': instance.productCount,
    };
