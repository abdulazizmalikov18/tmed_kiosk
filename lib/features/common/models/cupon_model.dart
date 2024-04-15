import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/entity/cupon_entity.dart';

part 'cupon_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderCouponModel extends OrderCouponEntity {
  const OrderCouponModel({
    super.id,
    super.name,
    super.discount,
  });

  factory OrderCouponModel.fromJson(Map<String, dynamic> json) =>
      _$OrderCouponModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCouponModelToJson(this);
}
