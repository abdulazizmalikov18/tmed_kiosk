import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/image_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/product_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/spec_cat_entity.dart';

part 'product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductModel extends ProductEntity {
  const ProductModel({
    super.code,
    super.name,
    super.manufacturer,
    super.type,
    super.unit,
    super.image,
    super.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
