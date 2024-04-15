import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/data/model/supplies_model.dart';

class SuppliesEntity extends Equatable {
  final int id;
  final int quantity;
  final int remains;
  final String expiryDate;
  final double purchasePrice;
  final int supply;
  final int product;
  final String currency;

  const SuppliesEntity({
    this.id = 0,
    this.quantity = 0,
    this.remains = 0,
    this.expiryDate = '',
    this.purchasePrice = 0,
    this.supply = 0,
    this.product = 0,
    this.currency = '',
  });

  @override
  List<Object?> get props => [
        id,
        quantity,
        remains,
        expiryDate,
        purchasePrice,
        supply,
        product,
        currency,
      ];
}

class PriceConverter
    implements JsonConverter<SuppliesEntity, Map<String, dynamic>?> {
  const PriceConverter();
  @override
  SuppliesEntity fromJson(Map<String, dynamic>? json) =>
      SuppliesModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(SuppliesEntity object) => {};
}
