// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cupon_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CuponResModel _$CuponResModelFromJson(Map<String, dynamic> json) =>
    CuponResModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      user: json['user'] as String? ?? "",
      date: json['date'] as String? ?? "",
    );

Map<String, dynamic> _$CuponResModelToJson(CuponResModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'date': instance.date,
    };
