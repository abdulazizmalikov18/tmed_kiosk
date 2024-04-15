import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/entity/kassa_org_entity.dart';

part 'kassa_org_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class KassaOrgModel extends KassaOrgEntity {
  const KassaOrgModel({
    super.id,
    super.name,
    super.slugName,
    super.logo,
    super.phone,
    super.operationType,
    super.address,
  });

  factory KassaOrgModel.fromJson(Map<String, dynamic> json) =>
      _$KassaOrgModelFromJson(json);

  Map<String, dynamic> toJson() => _$KassaOrgModelToJson(this);
}
