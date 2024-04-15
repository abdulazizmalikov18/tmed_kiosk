// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryStatusModel _$HistoryStatusModelFromJson(Map<String, dynamic> json) =>
    HistoryStatusModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      flow: json['flow'] as int? ?? 0,
      key: json['key'] as String? ?? '',
      order: json['order'] as int? ?? 0,
      isVisible: json['is_visible'] as bool? ?? false,
      toFinish: json['to_finish'] as bool? ?? false,
      toCancel: json['to_cancel'] as bool? ?? false,
      isDefault: json['is_default'] as bool? ?? false,
      productCount: json['product_count'] ?? false,
    );

Map<String, dynamic> _$HistoryStatusModelToJson(HistoryStatusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'flow': instance.flow,
      'key': instance.key,
      'order': instance.order,
      'is_visible': instance.isVisible,
      'to_finish': instance.toFinish,
      'to_cancel': instance.toCancel,
      'is_default': instance.isDefault,
      'product_count': instance.productCount,
    };
