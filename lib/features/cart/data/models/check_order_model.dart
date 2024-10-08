// To parse this JSON data, do
//
//     final checkOrderModel = checkOrderModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'check_order_model.g.dart';

CheckOrderModel checkOrderModelFromJson(String str) => CheckOrderModel.fromJson(json.decode(str));

String checkOrderModelToJson(CheckOrderModel data) => json.encode(data.toJson());

@JsonSerializable()
class CheckOrderModel {
    @JsonKey(name: "status")
    final String status;
    @JsonKey(name: "orders")
    final Orders? orders;

    CheckOrderModel({
        required this.status,
        required this.orders,
    });

    factory CheckOrderModel.fromJson(Map<String, dynamic> json) => _$CheckOrderModelFromJson(json);

    Map<String, dynamic> toJson() => _$CheckOrderModelToJson(this);
}

@JsonSerializable()
class Orders {
    @JsonKey(name: "id")
    final String id;
    @JsonKey(name: "number")
    final int number;

    Orders({
        required this.id,
        required this.number,
    });

    factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

    Map<String, dynamic> toJson() => _$OrdersToJson(this);
}
