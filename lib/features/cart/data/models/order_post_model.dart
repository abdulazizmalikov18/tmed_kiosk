import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/order_post_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/pay_order_set_entity.dart';

part 'order_post_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderPostModel extends OrderPostEntity {
  const OrderPostModel({
    super.action,
    super.cart,
    super.card,
    super.paymentinorderSet,
    super.processStatus,
    super.clientComment,
    super.coupon,
    super.payment,
    super.specsComment,
  });

  factory OrderPostModel.fromJson(Map<String, dynamic> json) =>
      _$OrderPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderPostModelToJson(this);
}
