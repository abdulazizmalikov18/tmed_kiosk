// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_current_work_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryCurrentWorkStateModel _$HistoryCurrentWorkStateModelFromJson(
        Map<String, dynamic> json) =>
    HistoryCurrentWorkStateModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      status: json['status'] == null
          ? const HistoryStatusEntity()
          : const HistoryStatusConverter()
              .fromJson(json['status'] as Map<String, dynamic>?),
      specialist: json['specialist'] == null
          ? const HistoryResponsibleEntity()
          : const HistoryResponsibleConverter()
              .fromJson(json['specialist'] as Map<String, dynamic>?),
      readOnly: json['read_only'] as bool? ?? false,
      startTime: json['start_time'] as String? ?? '',
      endTime: json['end_time'] as String? ?? '',
      createDate: json['create_date'] as String? ?? '',
      isCurrent: json['is_current'] as bool? ?? false,
      product: (json['product'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$HistoryCurrentWorkStateModelToJson(
        HistoryCurrentWorkStateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': const HistoryStatusConverter().toJson(instance.status),
      'specialist':
          const HistoryResponsibleConverter().toJson(instance.specialist),
      'read_only': instance.readOnly,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'create_date': instance.createDate,
      'is_current': instance.isCurrent,
      'product': instance.product,
    };
