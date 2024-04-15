import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/supplies_entity.dart';

part 'supplies_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SuppliesModel extends SuppliesEntity {
  const SuppliesModel({
    super.id,
    super.quantity,
    super.remains,
    super.expiryDate,
    super.purchasePrice,
    super.supply,
    super.product,
    super.currency,
  });

  factory SuppliesModel.fromJson(Map<String, dynamic> json) =>
      _$SuppliesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SuppliesModelToJson(this);
}
