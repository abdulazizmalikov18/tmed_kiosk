import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/feature_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/prepared_value_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/product_feature_entity.dart';

part 'product_feature_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductFeatureModel extends ProductFeatureEntity {
  const ProductFeatureModel({
    super.id,
    super.feature,
    super.value,
    super.preparedValue,
  });

  factory ProductFeatureModel.fromJson(Map<String, dynamic> json) =>
      _$ProductFeatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductFeatureModelToJson(this);
}
