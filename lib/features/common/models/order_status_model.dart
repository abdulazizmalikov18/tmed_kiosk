import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/entity/order_status_entity.dart';

part 'order_status_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderStatusModel extends OrderStatusEntity {
  const OrderStatusModel({
    super.id,
    super.name,
    super.flow,
    super.key,
    super.toFinish,
    super.toCancel,
    super.isDefault,
    super.productCount,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusModelToJson(this);
}
