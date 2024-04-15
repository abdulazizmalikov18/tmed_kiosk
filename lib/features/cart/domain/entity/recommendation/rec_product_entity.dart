import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/data/models/recommendation/rec_product_model.dart';

class RecProductEntity extends Equatable {
  final int id;
  final int orgProductId;
  final int product;
  final int qty;
  final String date;
  final bool isDeleted;

  const RecProductEntity({
    this.id = 0,
    this.orgProductId = 0,
    this.product = 0,
    this.qty = 0,
    this.date = "",
    this.isDeleted = false,
  });

  @override
  List<Object?> get props => [
        id,
        orgProductId,
        product,
        qty,
        date,
        isDeleted,
      ];
}

class RecProductConverter
    implements JsonConverter<RecProductEntity, Map<String, dynamic>?> {
  const RecProductConverter();
  @override
  RecProductEntity fromJson(Map<String, dynamic>? json) =>
      RecProductModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(RecProductEntity object) => {};
}
