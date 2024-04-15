// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountModel _$UserAccountModelFromJson(Map<String, dynamic> json) =>
    UserAccountModel(
      username: json['username'] as String? ?? "",
      name: json['name'] as String? ?? "",
      lastname: json['lastname'] as String? ?? "",
      surname: json['surname'] as String? ?? "",
      phone: json['phone'] as String? ?? "",
      gender: json['gender'] as String? ?? "",
      birthday: json['birthday'] as String? ?? "",
      mainCat: json['main_cat'] as String? ?? "",
      region: json['region'] as int? ?? 0,
      qrcode: json['qrcode'] as String? ?? "",
      pinfl: json['pinfl'] as String? ?? "",
    );

Map<String, dynamic> _$UserAccountModelToJson(UserAccountModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'lastname': instance.lastname,
      'surname': instance.surname,
      'phone': instance.phone,
      'gender': instance.gender,
      'birthday': instance.birthday,
      'main_cat': instance.mainCat,
      'region': instance.region,
      'qrcode': instance.qrcode,
      'pinfl': instance.pinfl,
    };
