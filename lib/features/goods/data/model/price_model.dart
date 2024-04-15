import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/price_entity.dart';

part 'price_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PriceModel extends PriceEntity {
  const PriceModel({
    super.id,
    super.value,
    super.currency,
    super.discount,
    super.active,
    super.maxQty,
    super.minQty,
    super.discountPrice,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) =>
      _$PriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PriceModelToJson(this);
}
