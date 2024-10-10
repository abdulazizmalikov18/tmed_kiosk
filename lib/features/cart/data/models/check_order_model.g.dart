// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOrderModel _$CheckOrderModelFromJson(Map<String, dynamic> json) =>
    CheckOrderModel(
      status: json['status'] as String,
      orders: json['orders'] == null
          ? null
          : Orders.fromJson(json['orders'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckOrderModelToJson(CheckOrderModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'orders': instance.orders,
    };

Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
      id: json['id'] as String,
      number: (json['number'] as num).toInt(),
    );

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
    };
