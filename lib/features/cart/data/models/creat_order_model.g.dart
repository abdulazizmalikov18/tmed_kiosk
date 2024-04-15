// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creat_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderModel _$CreateOrderModelFromJson(Map<String, dynamic> json) =>
    CreateOrderModel(
      action: json['action'] as String? ?? "",
      cartProducts: (json['cart_products'] as List<dynamic>?)
              ?.map((e) => const CartProductConverter()
                  .fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
      paymentCard: json['payment_card'] as int? ?? 0,
      payments: (json['payments'] as List<dynamic>?)
              ?.map((e) => const PayOrderSetConverter()
                  .fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
      clientComment: json['client_comment'] as String? ?? "",
      couponId: json['coupon_id'] as int? ?? 0,
      processStatus: json['process_status'] as int? ?? 0,
      clientUsername: json['client_username'] as String? ?? "",
    );

Map<String, dynamic> _$CreateOrderModelToJson(CreateOrderModel instance) =>
    <String, dynamic>{
      'action': instance.action,
      'cart_products': instance.cartProducts
          .map(const CartProductConverter().toJson)
          .toList(),
      'payment_card': instance.paymentCard,
      'payments':
          instance.payments.map(const PayOrderSetConverter().toJson).toList(),
      'client_comment': instance.clientComment,
      'coupon_id': instance.couponId,
      'process_status': instance.processStatus,
      'client_username': instance.clientUsername,
    };
