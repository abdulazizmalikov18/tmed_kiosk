import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/day_orders.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/break_list.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/today_time_table_entity.dart';

part 'today_time_table_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TodayTimetableModel extends TodayTimetableEntity {
  const TodayTimetableModel({
    super.id,
    super.breaksList,
    super.orders,
    super.dayOfWeek,
    super.startTime,
    super.endTime,
    super.isWorking,
    super.repeatDayOff,
    super.procInterval,
    super.spec,
  });

  factory TodayTimetableModel.fromJson(Map<String, dynamic> json) =>
      _$TodayTimetableModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodayTimetableModelToJson(this);
}
