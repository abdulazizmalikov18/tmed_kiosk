import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/entity/creator_entity.dart';
import 'package:tmed_kiosk/features/common/entity/order_status_entity.dart';
import 'package:tmed_kiosk/features/common/models/current_work_state_model.dart';

class CurrentWorkStateEntity extends Equatable {
  final int id;
  final int count;
  @OrderStatusConverter()
  final OrderStatusEntity status;
  @CreatorConverter()
  final CreatorEntity specialist;
  final dynamic startTime;
  final dynamic endTime;
  final String createDate;
  final int product;

  const CurrentWorkStateEntity({
    this.id = 0,
    this.count = 0,
    this.status = const OrderStatusEntity(),
    this.specialist = const CreatorEntity(),
    this.startTime = '',
    this.endTime = '',
    this.createDate = '',
    this.product = 0,
  });

  @override
  List<Object?> get props => [
        id,
        count,
        status,
        specialist,
        startTime,
        endTime,
        createDate,
        product,
      ];
}

class CurrentWorkStateConverter
    implements JsonConverter<CurrentWorkStateEntity, Map<String, dynamic>?> {
  const CurrentWorkStateConverter();

  @override
  CurrentWorkStateEntity fromJson(Map<String, dynamic>? json) =>
      CurrentWorkStateModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(CurrentWorkStateEntity object) => {};
}
