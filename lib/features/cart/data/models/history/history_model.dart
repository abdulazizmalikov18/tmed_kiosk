import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_current_work_state_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_order_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_responsible_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_unit_entity.dart';

part 'history_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HistoryModel extends HistoryEntity {
  const HistoryModel({
    super.id,
    super.name,
    super.order,
    super.cost,
    super.fullCost,
    super.vat,
    super.coupon,
    super.surcharge,
    super.currentWorkState,
    super.unit,
    super.meetDate,
    super.responsible,
    super.discountType,
    super.queueNumber,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
