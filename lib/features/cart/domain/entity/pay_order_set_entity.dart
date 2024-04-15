import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/data/models/pay_order_set_model.dart';

class PaymentinorderSet extends Equatable {
  final int method;
  final int cost;

  const PaymentinorderSet({
    this.method = 0,
    this.cost = 0,
  });

  @override
  List<Object?> get props => [
        method,
        cost,
      ];
}

class PayOrderSetConverter
    implements JsonConverter<PaymentinorderSet, Map<String, dynamic>?> {
  const PayOrderSetConverter();
  @override
  PaymentinorderSet fromJson(Map<String, dynamic>? json) =>
      PayOrderSetModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(PaymentinorderSet object) => {};
}
