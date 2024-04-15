import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/models/cupon_model.dart';

class OrderCouponEntity extends Equatable {
  final int id;
  final String name;
  final double discount;

  const OrderCouponEntity({
    this.id = 0,
    this.name = '',
    this.discount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        discount,
      ];
}

class OrderCouponConverter
    implements JsonConverter<OrderCouponEntity, Map<String, dynamic>?> {
  const OrderCouponConverter();

  @override
  OrderCouponEntity fromJson(Map<String, dynamic>? json) =>
      OrderCouponModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(OrderCouponEntity object) => {};
}
