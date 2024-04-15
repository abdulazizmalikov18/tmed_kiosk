import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/entity/user_order_entity.dart';

part 'order_user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderUserModel extends OrderUserEntity {
  const OrderUserModel({
    super.username,
    super.name,
    super.lastname,
    super.avatar,
    super.birthdate,
    super.region,
    super.gender,
    super.mainCat,
  });

  factory OrderUserModel.fromJson(Map<String, dynamic> json) =>
      _$OrderUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderUserModelToJson(this);
}
