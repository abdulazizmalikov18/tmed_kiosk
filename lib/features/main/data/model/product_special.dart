import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/main/domain/entity/product_specia.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/specialist_entity.dart';

part 'product_special.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductSpecialModel extends ProductSpecialEntity {
  const ProductSpecialModel({
    super.id,
    super.specialist,
    super.product,
  });

  factory ProductSpecialModel.fromJson(Map<String, dynamic> json) =>
      _$ProductSpecialModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSpecialModelToJson(this);
}
