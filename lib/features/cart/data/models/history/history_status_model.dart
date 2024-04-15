import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_status_entity.dart';

part 'history_status_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HistoryStatusModel extends HistoryStatusEntity {
  const HistoryStatusModel({
    super.id,
    super.name,
    super.flow,
    super.key,
    super.order,
    super.isVisible,
    super.toFinish,
    super.toCancel,
    super.isDefault,
    super.productCount,
  });

  factory HistoryStatusModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryStatusModelToJson(this);
}
