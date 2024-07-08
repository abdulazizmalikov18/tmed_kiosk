// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartProductModel _$CartProductModelFromJson(Map<String, dynamic> json) =>
    CartProductModel(
      product: (json['product'] as num?)?.toInt() ?? 0,
      responsible: (json['responsible'] as num?)?.toInt() ?? 0,
      qty: (json['qty'] as num?)?.toInt() ?? 0,
      surchargeIds: (json['surcharge_ids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      supply: (json['supply'] as num?)?.toInt() ?? 0,
      meetDate: json['meet_date'] as String? ?? '',
      recommendationProduct:
          (json['recommendation_product'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CartProductModelToJson(CartProductModel instance) =>
    <String, dynamic>{
      'product': instance.product,
      'responsible': instance.responsible,
      'meet_date': instance.meetDate,
      'qty': instance.qty,
      'surcharge_ids': instance.surchargeIds,
      'supply': instance.supply,
      'recommendation_product': instance.recommendationProduct,
    };
