// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryOrderModel _$HistoryOrderModelFromJson(Map<String, dynamic> json) =>
    HistoryOrderModel(
      id: json['id'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      createDate: json['create_date'] as String? ?? '',
      finishDate: json['finish_date'] as String? ?? '',
      paymentStatus: json['payment_status'] as int? ?? 0,
      paymentMethod: json['payment_method'] as int? ?? 0,
      creator: json['creator'] == null
          ? const HistoryResponsibleEntity()
          : const HistoryResponsibleConverter()
              .fromJson(json['creator'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$HistoryOrderModelToJson(HistoryOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'create_date': instance.createDate,
      'finish_date': instance.finishDate,
      'payment_status': instance.paymentStatus,
      'payment_method': instance.paymentMethod,
      'creator': const HistoryResponsibleConverter().toJson(instance.creator),
    };
