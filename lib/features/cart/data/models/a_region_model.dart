import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/a_region_entity.dart';

part 'a_region_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ARegionModel extends ARegionEntity {
  const ARegionModel({
    super.id,
    super.name,
    super.status,
    super.type,
    super.userCount,
    super.parent,
  });

  factory ARegionModel.fromJson(Map<String, dynamic> json) =>
      _$ARegionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ARegionModelToJson(this);
}
