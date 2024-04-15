import 'package:equatable/equatable.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_current_work_state_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_order_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_responsible_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_unit_entity.dart';

class HistoryEntity extends Equatable {
  final int id;
  final String name;
  @HistoryOrderConverter()
  final HistoryOrderEntity order;
  final double cost;
  final double fullCost;
  final int vat;
  final dynamic coupon;
  final double surcharge;
  @HistoryCurrentWorkStateConverter()
  final HistoryCurrentWorkStateEntity currentWorkState;
  @HistoryUnitConverter()
  final HistoryUnitEntity unit;
  final String meetDate;
  @HistoryResponsibleConverter()
  final HistoryResponsibleEntity responsible;
  final String discountType;
  final int queueNumber;

  const HistoryEntity({
    this.id = 0,
    this.name = "",
    this.order = const HistoryOrderEntity(),
    this.cost = 0,
    this.fullCost = 0,
    this.vat = 0,
    this.coupon = 0,
    this.surcharge = 0,
    this.currentWorkState = const HistoryCurrentWorkStateEntity(),
    this.unit = const HistoryUnitEntity(),
    this.meetDate = "",
    this.responsible = const HistoryResponsibleEntity(),
    this.discountType = "",
    this.queueNumber = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        order,
        cost,
        fullCost,
        vat,
        coupon,
        surcharge,
        currentWorkState,
        unit,
        meetDate,
        responsible,
        discountType,
        queueNumber,
      ];
}
