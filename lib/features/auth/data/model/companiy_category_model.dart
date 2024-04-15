import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/auth/domain/entity/companiy_category_entity.dart';

part 'companiy_category_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompaniyCategoryModel extends CompaniyCategoryEntity {
  const CompaniyCategoryModel({
    super.id,
    super.name,
    super.description,
    super.hideFromOrgs,
    super.hideFromUsers,
    super.image,
    super.status,
    super.firstLevelScore,
    super.levelProgressBy,
    super.parent,
  });

  factory CompaniyCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CompaniyCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompaniyCategoryModelToJson(this);
}
