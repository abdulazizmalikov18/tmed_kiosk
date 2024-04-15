// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pr_order_set_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrOrderSetModel _$PrOrderSetModelFromJson(Map<String, dynamic> json) =>
    PrOrderSetModel(
      product: json['product'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      qty: json['qty'] as int? ?? 0,
      cost: json['cost'] as int? ?? 0,
      fullCost: json['full_cost'] as int? ?? 0,
      surcharge: json['surcharge'] as int? ?? 0,
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
    };
