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
      mainCat: json['main_cat'] == null
          ? const MainCatEntity()
          : const MainCatConverter()
              .fromJson(json['main_cat'] as Map<String, dynamic>?),
      region: json['region'] == null
          ? const ARegionEntity()
          : const ARegionConverter()
              .fromJson(json['region'] as Map<String, dynamic>?),
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
      'main_cat': const MainCatConverter().toJson(instance.mainCat),
      'region': const ARegionConverter().toJson(instance.region),
      'qrcode': instance.qrcode,
      'pinfl': instance.pinfl,
    };
