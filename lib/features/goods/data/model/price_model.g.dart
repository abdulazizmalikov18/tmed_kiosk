// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceModel _$PriceModelFromJson(Map<String, dynamic> json) => PriceModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      value: (json['value'] as num?)?.toDouble() ?? 0,
      currency: json['currency'] as String? ?? '',
      discount: (json['discount'] as num?)?.toInt() ?? 0,
      active: json['active'] as bool? ?? false,
      maxQty: (json['max_qty'] as num?)?.toInt(),
      minQty: (json['min_qty'] as num?)?.toInt(),
      discountPrice: (json['discount_price'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$PriceModelToJson(PriceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'currency': instance.currency,
      'discount': instance.discount,
      'active': instance.active,
      'max_qty': instance.maxQty,
      'min_qty': instance.minQty,
      'discount_price': instance.discountPrice,
    };
