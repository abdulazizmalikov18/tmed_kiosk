// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductModel _$OrderProductModelFromJson(Map<String, dynamic> json) =>
    OrderProductModel(
      id: json['id'] as int? ?? 0,
      order: json['order'] as String? ?? '',
      product: json['product'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      qty: json['qty'] as int? ?? 0,
      cost: (json['cost'] as num?)?.toDouble() ?? 0,
      coupon: json['coupon'] == null
          ? const OrderCouponEntity()
          : const OrderCouponConverter()
              .fromJson(json['coupon'] as Map<String, dynamic>?),
      status: json['status'] as int? ?? 0,
      fullCost: (json['full_cost'] as num?)?.toDouble() ?? 0,
      surcharge: (json['surcharge'] as num?)?.toDouble() ?? 0,
      meetDate: json['meet_date'] as String? ?? '',
      expectedEndDate: json['expected_end_date'] as String? ?? '',
      responsible: json['responsible'] == null
          ? const CreatorEntity()
          : const CreatorConverter()
              .fromJson(json['responsible'] as Map<String, dynamic>?),
      image: json['image'] as String? ?? '',
      createDate: json['create_date'] ?? '',
      finishDate: json['finish_date'] ?? '',
    );

Map<String, dynamic> _$OrderProductModelToJson(OrderProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'product': instance.product,
      'name': instance.name,
      'qty': instance.qty,
      'cost': instance.cost,
      'coupon': const OrderCouponConverter().toJson(instance.coupon),
      'status': instance.status,
      'full_cost': instance.fullCost,
      'surcharge': instance.surcharge,
      'meet_date': instance.meetDate,
      'expected_end_date': instance.expectedEndDate,
      'responsible': const CreatorConverter().toJson(instance.responsible),
      'image': instance.image,
      'create_date': instance.createDate,
      'finish_date': instance.finishDate,
    };
