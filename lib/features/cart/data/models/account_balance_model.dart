// To parse this JSON data, do
//
//     final accountBalanceModel = accountBalanceModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'account_balance_model.g.dart';

AccountBalanceModel accountBalanceModelFromJson(String str) =>
    AccountBalanceModel.fromJson(json.decode(str));

String accountBalanceModelToJson(AccountBalanceModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class AccountBalanceModel {
  @JsonKey(name: "all_sum")
  final int allSum;
  @JsonKey(name: "paid")
  final int paid;
  @JsonKey(name: "coupon")
  final int coupon;
  @JsonKey(name: "debt")
  final int debt;

  const AccountBalanceModel({
    this.allSum = 0,
    this.paid = 0,
    this.coupon = 0,
    this.debt = 0,
  });

  factory AccountBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$AccountBalanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountBalanceModelToJson(this);
}
