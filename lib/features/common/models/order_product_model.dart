import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/entity/creator_entity.dart';
import 'package:tmed_kiosk/features/common/entity/cupon_entity.dart';
import 'package:tmed_kiosk/features/common/entity/order_product_entity.dart';

part 'order_product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderProductModel extends OrderProductEntity {
  const OrderProductModel({
    super.id,
    super.order,
    super.product,
    super.name,
    super.qty,
    super.cost,
    super.coupon,
    super.status,
    super.fullCost,
    super.surcharge,
    super.meetDate,
    super.expectedEndDate,
    super.responsible,
    super.image,
    super.createDate,
    super.finishDate,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductModelToJson(this);
}
