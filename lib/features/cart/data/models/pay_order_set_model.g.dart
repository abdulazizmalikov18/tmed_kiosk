// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_order_set_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayOrderSetModel _$PayOrderSetModelFromJson(Map<String, dynamic> json) =>
    PayOrderSetModel(
      method: json['method'] as int? ?? 0,
      cost: json['cost'] as int? ?? 0,
    );

Map<String, dynamic> _$PayOrderSetModelToJson(PayOrderSetModel instance) =>
    <String, dynamic>{
      'method': instance.method,
      'cost': instance.cost,
    };
