import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/create_account.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/user_account_entity.dart';

part 'create_account_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateAccountModel extends CreateAccountEntity {
  const CreateAccountModel({
    super.access,
    super.refresh,
    super.user,
  });

  factory CreateAccountModel.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountModelToJson(this);
}
