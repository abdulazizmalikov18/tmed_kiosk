// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCouponModel _$OrderCouponModelFromJson(Map<String, dynamic> json) =>
    OrderCouponModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      discount: (json['discount'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$OrderCouponModelToJson(OrderCouponModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'discount': instance.discount,
    };
