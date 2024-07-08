// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'break_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreaksListModel _$BreaksListModelFromJson(Map<String, dynamic> json) =>
    BreaksListModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      endTime: json['end_time'] as String? ?? '',
      startTime: json['start_time'] as String? ?? '',
      timeTable: (json['time_table'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$BreaksListModelToJson(BreaksListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'time_table': instance.timeTable,
    };
