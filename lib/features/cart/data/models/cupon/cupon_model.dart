import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/cupon_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/extra_entity.dart';

part 'cupon_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CuponModel extends CuponEntity {
  const CuponModel({
    super.id,
    super.extra,
    super.organization,
    super.title,
    super.org,
    super.user,
    super.productDiscount,
    super.backgroundColor,
    super.backgroundImage,
    super.date,
  });

  factory CuponModel.fromJson(Map<String, dynamic> json) =>
      _$CuponModelFromJson(json);

  Map<String, dynamic> toJson() => _$CuponModelToJson(this);
}
