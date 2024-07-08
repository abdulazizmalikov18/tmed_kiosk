import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/entity/creator_entity.dart';
import 'package:tmed_kiosk/features/common/entity/cupon_entity.dart';
import 'package:tmed_kiosk/features/common/entity/current_work_state_etity.dart';
import 'package:tmed_kiosk/features/common/models/order_product_model.dart';

class OrderProductEntity extends Equatable {
  final int id;
  final String order;
  final int product;
  final String name;
  final int qty;
  final double cost;
  @OrderCouponConverter()
  final OrderCouponEntity coupon;
  final int status;
  final double fullCost;
  final double surcharge;
  final String meetDate;
  final String expectedEndDate;
  @CreatorConverter()
  final CreatorEntity responsible;
  final String image;
  @CurrentWorkStateConverter()
  final CurrentWorkStateEntity currentWorkState;
  final dynamic createDate;
  final dynamic finishDate;
  final String textCheck;

  const OrderProductEntity({
    this.id = 0,
    this.order = '',
    this.product = 0,
    this.name = '',
    this.textCheck = '',
    this.qty = 0,
    this.cost = 0,
    this.coupon = const OrderCouponEntity(),
    this.status = 0,
    this.fullCost = 0,
    this.surcharge = 0,
    this.meetDate = '',
    this.expectedEndDate = '',
    this.responsible = const CreatorEntity(),
    this.image = '',
    this.currentWorkState = const CurrentWorkStateEntity(),
    this.createDate = '',
    this.finishDate = '',
  });

  @override
  List<Object?> get props => [
        id,
        order,
        product,
        textCheck,
        name,
        qty,
        cost,
        coupon,
        status,
        fullCost,
        surcharge,
        meetDate,
        expectedEndDate,
        responsible,
        image,
        currentWorkState,
        createDate,
        finishDate,
      ];
}

class OrderProductConverter
    implements JsonConverter<OrderProductEntity, Map<String, dynamic>?> {
  const OrderProductConverter();

  @override
  OrderProductEntity fromJson(Map<String, dynamic>? json) =>
      OrderProductModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(OrderProductEntity object) => {};
}
