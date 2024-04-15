import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/break_list.dart';

part 'break_list_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BreaksListModel extends BreaksListEntity {
  const BreaksListModel({
    super.id,
    super.endTime,
    super.startTime,
    super.timeTable,
  });

  factory BreaksListModel.fromJson(Map<String, dynamic> json) =>
      _$BreaksListModelFromJson(json);

  Map<String, dynamic> toJson() => _$BreaksListModelToJson(this);
}
