import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/creat_order_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/pay_order_set_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/product_cart_entity.dart';

part 'creat_order_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateOrderModel extends CreateOrderEntity {
  const CreateOrderModel({
    super.action,
    super.cartProducts,
    super.paymentCard,
    super.payments,
    // super.specsComment,
    super.clientComment,
    // super.meetAddress,
    super.couponId,
    super.processStatus,
    super.clientUsername,
  });

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderModelToJson(this);
}
