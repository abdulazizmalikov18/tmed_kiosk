// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayOrderModel _$DayOrderModelFromJson(Map<String, dynamic> json) =>
    DayOrderModel(
      meetDate: json['meetDate'] as String? ?? '',
      expectedEndDate: json['expectedEndDate'] as String? ?? '',
      responsible: json['responsible'] as int? ?? 0,
      user: json['user'],
    );

Map<String, dynamic> _$DayOrderModelToJson(DayOrderModel instance) =>
    <String, dynamic>{
      'meetDate': instance.meetDate,
      'expectedEndDate': instance.expectedEndDate,
      'responsible': instance.responsible,
      'user': instance.user,
    };
