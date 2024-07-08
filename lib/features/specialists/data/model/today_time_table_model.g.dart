// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_time_table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayTimetableModel _$TodayTimetableModelFromJson(Map<String, dynamic> json) =>
    TodayTimetableModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      breaksList: (json['breaks_list'] as List<dynamic>?)
              ?.map((e) => const BreaksListConverter()
                  .fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
      orders: (json['orders'] as List<dynamic>?)
              ?.map((e) => const DayOrderConverter()
                  .fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
      dayOfWeek: json['day_of_week'] as String? ?? '',
      startTime: json['start_time'] as String? ?? '',
      endTime: json['end_time'] as String? ?? '',
      isWorking: json['is_working'] as bool? ?? false,
      repeatDayOff: (json['repeat_day_off'] as num?)?.toInt() ?? 0,
      procInterval: (json['proc_interval'] as num?)?.toDouble() ?? 0,
      spec: (json['spec'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TodayTimetableModelToJson(
        TodayTimetableModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'breaks_list':
          instance.breaksList.map(const BreaksListConverter().toJson).toList(),
      'orders': instance.orders.map(const DayOrderConverter().toJson).toList(),
      'day_of_week': instance.dayOfWeek,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'is_working': instance.isWorking,
      'repeat_day_off': instance.repeatDayOff,
      'proc_interval': instance.procInterval,
      'spec': instance.spec,
    };
