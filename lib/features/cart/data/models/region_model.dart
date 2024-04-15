import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/region_entity.dart';

part 'region_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RegionModel extends RegionEntity {
  const RegionModel({
    super.id,
    super.name,
    super.isParent,
    // super.type,
    // super.userCount,
    super.parent,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) =>
      _$RegionModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegionModelToJson(this);
}
