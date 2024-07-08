// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountsModel _$AccountsModelFromJson(Map<String, dynamic> json) =>
    AccountsModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      username: json['username'] as String? ?? '',
      name: json['name'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      birthday: json['birthday'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
      avatar: (json['avatar'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      mainCat: json['main_cat'] == null
          ? const MainCatEntity()
          : const MainCatConverter()
              .fromJson(json['main_cat'] as Map<String, dynamic>?),
      pinfl: json['pinfl'] as String? ?? '',
      region: json['region'] == null
          ? const ARegionEntity()
          : const ARegionConverter()
              .fromJson(json['region'] as Map<String, dynamic>?),
      parents: json['parents'] as List<dynamic>? ?? const [],
      birthPlace: json['birth_place'] as String? ?? '',
      currentPlace: json['current_place'] as String? ?? '',
      education: json['education'] as String? ?? '',
      nationality: json['nationality'] as String? ?? '',
      surname: json['surname'] as String? ?? '',
      isAfgan: json['is_afgan'] as bool? ?? false,
      isCherno: json['is_cherno'] as bool? ?? false,
      isUvu: json['is_uvu'] as bool? ?? false,
      isInvalid: json['is_invalid'] as bool? ?? false,
      position: json['position'] as String? ?? "",
      type: json['type'] as String? ?? "",
    );

Map<String, dynamic> _$AccountsModelToJson(AccountsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'status': instance.status,
      'lastname': instance.lastname,
      'surname': instance.surname,
      'education': instance.education,
      'phone': instance.phone,
      'birth_place': instance.birthPlace,
      'nationality': instance.nationality,
      'current_place': instance.currentPlace,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'main_cat': const MainCatConverter().toJson(instance.mainCat),
      'pinfl': instance.pinfl,
      'region': const ARegionConverter().toJson(instance.region),
      'parents': instance.parents,
      'is_afgan': instance.isAfgan,
      'is_cherno': instance.isCherno,
      'is_invalid': instance.isInvalid,
      'is_uvu': instance.isUvu,
      'position': instance.position,
      'type': instance.type,
    };
