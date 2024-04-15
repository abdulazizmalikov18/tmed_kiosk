import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/day_orders.dart';
import 'package:tmed_kiosk/features/specialists/data/model/today_time_table_model.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/break_list.dart';

class TodayTimetableEntity extends Equatable {
  final int id;
  @BreaksListConverter()
  final List<BreaksListEntity> breaksList;
  @DayOrderConverter()
  final List<DayOrderEntity> orders;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final bool isWorking;
  final int repeatDayOff;
  final double procInterval;
  final int spec;

  const TodayTimetableEntity({
    this.id = 0,
    this.breaksList = const [],
    this.orders = const [],
    this.dayOfWeek = '',
    this.startTime = '',
    this.endTime = '',
    this.isWorking = false,
    this.repeatDayOff = 0,
    this.procInterval = 0,
    this.spec = 0,
  });

  @override
  List<Object?> get props => [
        id,
        breaksList,
        orders,
        dayOfWeek,
        startTime,
        endTime,
        isWorking,
        repeatDayOff,
        procInterval,
        spec,
      ];
}

class TodayTimetableConverter
    implements JsonConverter<TodayTimetableEntity, Map<String, dynamic>?> {
  const TodayTimetableConverter();
  @override
  TodayTimetableEntity fromJson(Map<String, dynamic>? json) =>
      TodayTimetableModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(TodayTimetableEntity object) => {};
}
