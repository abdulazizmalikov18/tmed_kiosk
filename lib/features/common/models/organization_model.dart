import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/entity/organization_entity.dart';

part 'organization_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrganizationModel extends OrganizationEntity {
  const OrganizationModel({
    super.slugName,
    super.name,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationModelToJson(this);
}
