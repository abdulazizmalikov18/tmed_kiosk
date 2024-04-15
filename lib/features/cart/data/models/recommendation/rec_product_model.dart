import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/recommendation/rec_product_entity.dart';

part 'rec_product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RecProductModel extends RecProductEntity {
  const RecProductModel({
    super.id,
    super.orgProductId,
    super.product,
    super.qty,
    super.date,
    super.isDeleted,
  });

  factory RecProductModel.fromJson(Map<String, dynamic> json) =>
      _$RecProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecProductModelToJson(this);
}
