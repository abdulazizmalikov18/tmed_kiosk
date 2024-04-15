import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/data/model/price_model.dart';

class PriceEntity extends Equatable {
  final int id;
  final double value;
  final String currency;
  final int discount;
  final bool active;
  final int maxQty;
  final int minQty;
  final double discountPrice;

  const PriceEntity({
    this.id = 0,
    this.value = 0,
    this.currency = '',
    this.discount = 0,
    this.active = false,
    this.maxQty = 0,
    this.minQty = 0,
    this.discountPrice = 0,
  });

  @override
  List<Object?> get props => [
        id,
        value,
        currency,
        discount,
        active,
        maxQty,
        minQty,
        discountPrice,
      ];
}

class PriceConverter
    implements JsonConverter<PriceEntity, Map<String, dynamic>?> {
  const PriceConverter();
  @override
  PriceEntity fromJson(Map<String, dynamic>? json) =>
      PriceModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(PriceEntity object) => {};
}
