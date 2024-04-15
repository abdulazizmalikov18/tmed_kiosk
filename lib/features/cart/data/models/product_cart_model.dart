import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/product_cart_entity.dart';

part 'product_cart_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CartProductModel extends CartProductEntity {
  const CartProductModel({
    super.product,
    super.responsible,
    super.qty,
    super.surchargeIds,
    super.supply,
    super.meetDate,
    super.recommendationProduct,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) =>
      _$CartProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductModelToJson(this);
}
