// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_work_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWorkStateModel _$CurrentWorkStateModelFromJson(
        Map<String, dynamic> json) =>
    CurrentWorkStateModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      count: (json['count'] as num?)?.toInt() ?? 0,
      status: json['status'] == null
          ? const OrderStatusEntity()
          : const OrderStatusConverter()
              .fromJson(json['status'] as Map<String, dynamic>?),
      specialist: json['specialist'] == null
          ? const CreatorEntity()
          : const CreatorConverter()
              .fromJson(json['specialist'] as Map<String, dynamic>?),
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      createDate: json['create_date'] as String? ?? '',
      product: (json['product'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CurrentWorkStateModelToJson(
        CurrentWorkStateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
      'status': const OrderStatusConverter().toJson(instance.status),
      'specialist': const CreatorConverter().toJson(instance.specialist),
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'create_date': instance.createDate,
      'product': instance.product,
    };
