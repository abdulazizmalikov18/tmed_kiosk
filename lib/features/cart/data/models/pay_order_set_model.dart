import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/pay_order_set_entity.dart';

part 'pay_order_set_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PayOrderSetModel extends PaymentinorderSet {
  const PayOrderSetModel({
    super.method,
    super.cost,
  });

  factory PayOrderSetModel.fromJson(Map<String, dynamic> json) =>
      _$PayOrderSetModelFromJson(json);

  Map<String, dynamic> toJson() => _$PayOrderSetModelToJson(this);
}
