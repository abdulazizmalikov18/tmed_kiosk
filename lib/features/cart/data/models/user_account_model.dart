import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/user_account_entity.dart';

part 'user_account_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserAccountModel extends UserAccountEntity {
  const UserAccountModel({
    super.username,
    super.name,
    super.lastname,
    super.surname,
    super.phone,
    super.gender,
    super.birthday,
    super.mainCat,
    super.region,
    super.qrcode,
    super.pinfl,
  });

  factory UserAccountModel.fromJson(Map<String, dynamic> json) =>
      _$UserAccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountModelToJson(this);
}
