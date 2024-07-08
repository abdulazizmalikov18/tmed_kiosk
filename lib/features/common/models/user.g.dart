// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      username: json['username'] as String? ?? '',
      name: json['name'] as String? ?? '',
      surname: json['surname'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] as String? ?? '',
      birthday: json['birthday'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      bio: json['bio'] ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
      isRelated: json['is_related'] as bool? ?? false,
      region: json['region'] == null
          ? const DataEntity()
          : const DataEntityConverter()
              .fromJson(json['region'] as Map<String, dynamic>?),
      mainCat: json['main_cat'] == null
          ? const DataEntity()
          : const DataEntityConverter()
              .fromJson(json['main_cat'] as Map<String, dynamic>?),
      avatar: json['avatar'] as String? ?? '',
      qrcode: json['qrcode'] as String? ?? '',
      hasPassword: json['has_password'] as bool? ?? false,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'surname': instance.surname,
      'lastname': instance.lastname,
      'email': instance.email,
      'phone': instance.phone,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'bio': instance.bio,
      'status': instance.status,
      'is_related': instance.isRelated,
      'region': const DataEntityConverter().toJson(instance.region),
      'main_cat': const DataEntityConverter().toJson(instance.mainCat),
      'avatar': instance.avatar,
      'qrcode': instance.qrcode,
      'has_password': instance.hasPassword,
    };
