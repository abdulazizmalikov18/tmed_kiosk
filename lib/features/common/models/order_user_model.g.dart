// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderUserModel _$OrderUserModelFromJson(Map<String, dynamic> json) =>
    OrderUserModel(
      username: json['username'] as String? ?? '',
      name: json['name'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      birthdate: json['birthdate'] as String? ?? '',
      region: json['region'],
      gender: json['gender'] as String? ?? '',
      mainCat: json['main_cat'],
    );

Map<String, dynamic> _$OrderUserModelToJson(OrderUserModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'lastname': instance.lastname,
      'avatar': instance.avatar,
      'birthdate': instance.birthdate,
      'region': instance.region,
      'gender': instance.gender,
      'main_cat': instance.mainCat,
    };
