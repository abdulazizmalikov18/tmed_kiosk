import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/data/models/pr_order_set_model.dart';

class PrOrderSetEntity extends Equatable {
  final int id;
  final int product;
  final String name;
  final int qty;
  final int cost;
  final int fullCost;
  final int surcharge;
  final String meetDate;
  final String expectedEndDate;
  final int responsible;
  final String image;
  final Map<String, Object>? coupon;

  const PrOrderSetEntity({
    this.id = 0,
    this.product = 0,
    this.name = "",
    this.qty = 0,
    this.cost = 0,
    this.fullCost = 0,
    this.surcharge = 0,
    this.meetDate = "",
    this.expectedEndDate = "",
    this.responsible = 0,
    this.image = "",
    this.coupon,
  });

  @override
  List<Object?> get props => [
        id,
        product,
        name,
        qty,
        cost,
        fullCost,
        surcharge,
        meetDate,
        expectedEndDate,
        responsible,
        image,
        coupon,
      ];
}

class PrOrderSetConverter
    implements JsonConverter<PrOrderSetEntity, Map<String, dynamic>?> {
  const PrOrderSetConverter();
  @override
  PrOrderSetEntity fromJson(Map<String, dynamic>? json) =>
      PrOrderSetModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(PrOrderSetEntity object) => {};
}
