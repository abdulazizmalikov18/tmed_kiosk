import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/a_region_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/accounts_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/main_cat_entity.dart';

part 'accounts_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AccountsModel extends AccountsEntity {
  const AccountsModel({
    super.id,
    super.username,
    super.name,
    super.lastname,
    super.phone,
    super.birthday,
    super.gender,
    super.status,
    super.avatar,
    super.mainCat,
    super.pinfl,
    super.region,
    super.parents,
  });

  factory AccountsModel.fromJson(Map<String, dynamic> json) =>
      _$AccountsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountsModelToJson(this);
}
