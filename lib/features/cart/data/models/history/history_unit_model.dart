import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_unit_entity.dart';

part 'history_unit_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HistoryUnitModel extends HistoryUnitEntity {
  const HistoryUnitModel({
    super.id,
    super.name,
  });

  factory HistoryUnitModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryUnitModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryUnitModelToJson(this);
}
