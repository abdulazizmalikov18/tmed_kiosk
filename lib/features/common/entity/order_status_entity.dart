import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/models/order_status_model.dart';

class OrderStatusEntity extends Equatable {
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

  const OrderStatusEntity({
    this.id = 0,
    this.name = '',
    this.flow = 0,
    this.key = '',
    this.toFinish = false,
    this.toCancel = false,
    this.isDefault = false,
    this.productCount = '',
    this.order = 0,
    this.isVisible = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        flow,
        key,
        toFinish,
        toCancel,
        isDefault,
        productCount,
        order,
        isVisible,
      ];
}

class OrderStatusConverter
    implements JsonConverter<OrderStatusEntity, Map<String, dynamic>?> {
  const OrderStatusConverter();

  @override
  OrderStatusEntity fromJson(Map<String, dynamic>? json) =>
      OrderStatusModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(OrderStatusEntity object) => {};
}
