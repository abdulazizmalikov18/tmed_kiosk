import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/data/models/history/history_current_work_state_model.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_responsible_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_status_entity.dart';

class HistoryCurrentWorkStateEntity extends Equatable {
  final int id;
  @HistoryStatusConverter()
  final HistoryStatusEntity status;
  @HistoryResponsibleConverter()
  final HistoryResponsibleEntity specialist;
  final bool readOnly;
  final String startTime;
  final String endTime;
  final String createDate;
  final bool isCurrent;
  final int product;

  const HistoryCurrentWorkStateEntity({
    this.id = 0,
    this.status = const HistoryStatusEntity(),
    this.specialist = const HistoryResponsibleEntity(),
    this.readOnly = false,
    this.startTime = '',
    this.endTime = '',
    this.createDate = '',
    this.isCurrent = false,
    this.product = 0,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        specialist,
        readOnly,
        startTime,
        endTime,
        createDate,
        isCurrent,
        product,
      ];
}

class HistoryCurrentWorkStateConverter
    implements
        JsonConverter<HistoryCurrentWorkStateEntity, Map<String, dynamic>?> {
  const HistoryCurrentWorkStateConverter();
  @override
  HistoryCurrentWorkStateEntity fromJson(Map<String, dynamic>? json) =>
      HistoryCurrentWorkStateModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(HistoryCurrentWorkStateEntity object) => {};
}
