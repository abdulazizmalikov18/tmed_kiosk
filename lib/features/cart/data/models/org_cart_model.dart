import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/org_cart_entity.dart';

part 'org_cart_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrgCartModel extends OrgCartEntity {
  const OrgCartModel({
    super.id,
    super.org,
    super.user,
    super.creator,
    super.createDate,
  });

  factory OrgCartModel.fromJson(Map<String, dynamic> json) =>
      _$OrgCartModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrgCartModelToJson(this);
}
