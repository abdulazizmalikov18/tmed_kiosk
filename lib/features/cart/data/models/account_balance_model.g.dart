// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountBalanceModel _$AccountBalanceModelFromJson(Map<String, dynamic> json) =>
    AccountBalanceModel(
      allSum: (json['all_sum'] as num?)?.toInt() ?? 0,
      paid: (json['paid'] as num?)?.toInt() ?? 0,
      coupon: (json['coupon'] as num?)?.toInt() ?? 0,
      debt: (json['debt'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AccountBalanceModelToJson(
        AccountBalanceModel instance) =>
    <String, dynamic>{
      'all_sum': instance.allSum,
      'paid': instance.paid,
      'coupon': instance.coupon,
      'debt': instance.debt,
    };
