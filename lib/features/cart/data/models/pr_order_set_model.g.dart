// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pr_order_set_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrOrderSetModel _$PrOrderSetModelFromJson(Map<String, dynamic> json) =>
    PrOrderSetModel(
      product: (json['product'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? "",
      qty: (json['qty'] as num?)?.toInt() ?? 0,
      cost: (json['cost'] as num?)?.toInt() ?? 0,
      fullCost: (json['full_cost'] as num?)?.toInt() ?? 0,
      surcharge: (json['surcharge'] as num?)?.toInt() ?? 0,
      coupon: (json['coupon'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as Object),
      ),
      image: json['image'] as String? ?? "",
    );

Map<String, dynamic> _$PrOrderSetModelToJson(PrOrderSetModel instance) =>
    <String, dynamic>{
      'product': instance.product,
      'name': instance.name,
      'qty': instance.qty,
      'cost': instance.cost,
      'full_cost': instance.fullCost,
      'surcharge': instance.surcharge,
      'image': instance.image,
      'coupon': instance.coupon,
    };
