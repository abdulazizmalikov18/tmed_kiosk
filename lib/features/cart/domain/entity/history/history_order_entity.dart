import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/data/models/history/history_order_model.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_responsible_entity.dart';

class HistoryOrderEntity extends Equatable {
  final String id;
  final int status;
  final String createDate;
  final String finishDate;
  final int paymentStatus;
  final int paymentMethod;
  @HistoryResponsibleConverter()
  final HistoryResponsibleEntity creator;

  const HistoryOrderEntity({
    this.id = '',
    this.status = 0,
    this.createDate = '',
    this.finishDate = '',
    this.paymentStatus = 0,
    this.paymentMethod = 0,
    this.creator = const HistoryResponsibleEntity(),
  });

  @override
  List<Object?> get props => [
        id,
        status,
        createDate,
        finishDate,
        paymentStatus,
        paymentMethod,
        creator,
      ];
}

class HistoryOrderConverter
    implements JsonConverter<HistoryOrderEntity, Map<String, dynamic>?> {
  const HistoryOrderConverter();
  @override
  HistoryOrderEntity fromJson(Map<String, dynamic>? json) =>
      HistoryOrderModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(HistoryOrderEntity object) => {};
}
