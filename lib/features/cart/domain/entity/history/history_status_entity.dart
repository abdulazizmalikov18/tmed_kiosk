import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/data/models/history/history_status_model.dart';

class HistoryStatusEntity extends Equatable {
  final int id;
  final String name;
  final int flow;
  final String key;
  final int order;
  final bool isVisible;
  final bool toFinish;
  final bool toCancel;
  final bool isDefault;
  final dynamic productCount;

  const HistoryStatusEntity({
    this.id = 0,
    this.name = '',
    this.flow = 0,
    this.key = '',
    this.order = 0,
    this.isVisible = false,
    this.toFinish = false,
    this.toCancel = false,
    this.isDefault = false,
    this.productCount = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        flow,
        key,
        order,
        isVisible,
        toFinish,
        toCancel,
        isDefault,
        productCount,
      ];
}

class HistoryStatusConverter
    implements JsonConverter<HistoryStatusEntity, Map<String, dynamic>?> {
  const HistoryStatusConverter();
  @override
  HistoryStatusEntity fromJson(Map<String, dynamic>? json) =>
      HistoryStatusModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(HistoryStatusEntity object) => {};
}
