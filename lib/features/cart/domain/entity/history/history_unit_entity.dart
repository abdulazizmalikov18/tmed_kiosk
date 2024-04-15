import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/data/models/history/history_unit_model.dart';

class HistoryUnitEntity extends Equatable {
  final int id;
  final String name;

  const HistoryUnitEntity({
    this.id = 0,
    this.name = '',
  });

  @override
  List<Object?> get props => [id, name];
}

class HistoryUnitConverter
    implements JsonConverter<HistoryUnitEntity, Map<String, dynamic>?> {
  const HistoryUnitConverter();
  @override
  HistoryUnitEntity fromJson(Map<String, dynamic>? json) =>
      HistoryUnitModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(HistoryUnitEntity object) => {};
}
