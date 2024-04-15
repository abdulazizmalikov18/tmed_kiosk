import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/feature_entity.dart';

part 'feature_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FeatureModel extends FeatureEntity {
  const FeatureModel({
    super.name,
    super.id,
    super.requiredFormat,
    super.multiValues,
    super.required,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) =>
      _$FeatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureModelToJson(this);
}
