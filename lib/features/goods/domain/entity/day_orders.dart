import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/data/model/day_order_model.dart';

class DayOrderEntity extends Equatable {
  final String meetDate;
  final String expectedEndDate;
  final int responsible;
  final dynamic user;

  const DayOrderEntity({
    this.meetDate = '',
    this.expectedEndDate = '',
    this.responsible = 0,
    this.user,
  });

  @override
  List<Object?> get props => [
        meetDate,
        expectedEndDate,
        responsible,
        user,
      ];
}

class DayOrderConverter
    implements JsonConverter<DayOrderEntity, Map<String, dynamic>?> {
  const DayOrderConverter();
  @override
  DayOrderEntity fromJson(Map<String, dynamic>? json) =>
      DayOrderModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(DayOrderEntity object) => {};
}
