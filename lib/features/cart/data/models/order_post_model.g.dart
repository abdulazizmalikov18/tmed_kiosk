// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPostModel _$OrderPostModelFromJson(Map<String, dynamic> json) =>
    OrderPostModel(
      action: json['action'] as String? ?? '',
      cart: json['cart'] as int? ?? 0,
      card: json['card'] as int? ?? 0,
      paymentinorderSet: (json['paymentinorder_set'] as List<dynamic>?)
              ?.map((e) => const PayOrderSetConverter()
                  .fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
      processStatus: json['process_status'] as int? ?? 0,
      clientComment: json['client_comment'] as String? ?? '',
      coupon: json['coupon'] as int? ?? 0,
      payment: json['payment'] as int? ?? 0,
      specsComment: json['specs_comment'] as String? ?? '',
    );

Map<String, dynamic> _$OrderPostModelToJson(OrderPostModel instance) =>
    <String, dynamic>{
      'cart': instance.cart,
      'card': instance.card,
      'payment': instance.payment,
      'specs_comment': instance.specsComment,
      'client_comment': instance.clientComment,
      'coupon': instance.coupon,
      'action': instance.action,
      'paymentinorder_set': instance.paymentinorderSet
          .map(const PayOrderSetConverter().toJson)
          .toList(),
      'process_status': instance.processStatus,
    };
