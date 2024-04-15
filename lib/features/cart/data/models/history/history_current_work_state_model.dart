import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_current_work_state_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_responsible_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_status_entity.dart';

part 'history_current_work_state_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HistoryCurrentWorkStateModel extends HistoryCurrentWorkStateEntity {
  const HistoryCurrentWorkStateModel({
    super.id,
    super.status,
    super.specialist,
    super.readOnly,
    super.startTime,
    super.endTime,
    super.createDate,
    super.isCurrent,
    super.product,
  });

  factory HistoryCurrentWorkStateModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryCurrentWorkStateModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryCurrentWorkStateModelToJson(this);
}
