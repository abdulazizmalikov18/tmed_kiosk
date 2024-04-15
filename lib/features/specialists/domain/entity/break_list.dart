import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/specialists/data/model/break_list_model.dart';

class BreaksListEntity extends Equatable {
  final int id;
  final String startTime;
  final String endTime;
  final int timeTable;

  const BreaksListEntity({
    this.id = 0,
    this.startTime = '',
    this.endTime = '',
    this.timeTable = 0,
  });

  @override
  List<Object?> get props => [id, startTime, endTime, timeTable];
}

class BreaksListConverter
    implements JsonConverter<BreaksListEntity, Map<String, dynamic>?> {
  const BreaksListConverter();
  @override
  BreaksListEntity fromJson(Map<String, dynamic>? json) =>
      BreaksListModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(BreaksListEntity object) => {};
}
