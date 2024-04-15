import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/data/models/product_cart_model.dart';

class CartProductEntity extends Equatable {
  final int product;
  final int responsible;
  final String meetDate;
  final int qty;
  final List<int> surchargeIds;
  final int supply;
  final int recommendationProduct;

  const CartProductEntity({
    this.product = 0,
    this.responsible = 0,
    this.qty = 0,
    this.surchargeIds = const [],
    this.supply = 0,
    this.meetDate = '',
    this.recommendationProduct = 0,
  });

  @override
  List<Object?> get props => [
        product,
        responsible,
        qty,
        surchargeIds,
        supply,
        meetDate,
        recommendationProduct,
      ];
}

class CartProductConverter
    implements JsonConverter<CartProductEntity, Map<String, dynamic>?> {
  const CartProductConverter();
  @override
  CartProductEntity fromJson(Map<String, dynamic>? json) =>
      CartProductModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(CartProductEntity object) => {};
}
