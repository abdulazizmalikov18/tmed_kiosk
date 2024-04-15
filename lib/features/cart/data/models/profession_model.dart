import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/profession_entity.dart';

part 'profession_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfessionModel extends ProfessionEntity {
  const ProfessionModel({
    super.id,
    super.isParent,
    super.childNumber,
    super.name,
    super.hideFromOrgs,
    super.hideFromUsers,
    super.image,
    super.status,
    super.description,
    super.firstLevelScore,
    super.levelProgressBy,
    super.parent,
  });

  factory ProfessionModel.fromJson(Map<String, dynamic> json) =>
      _$ProfessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfessionModelToJson(this);
}
