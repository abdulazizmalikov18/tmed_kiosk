import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_order_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_responsible_entity.dart';

part 'history_order_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HistoryOrderModel extends HistoryOrderEntity {
  const HistoryOrderModel({
    super.id,
    super.status,
    super.createDate,
    super.finishDate,
    super.paymentStatus,
    super.paymentMethod,
    super.creator,
  });

  factory HistoryOrderModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryOrderModelToJson(this);
}
