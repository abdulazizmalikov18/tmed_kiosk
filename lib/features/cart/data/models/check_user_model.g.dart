// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUserModel _$CheckUserModelFromJson(Map<String, dynamic> json) =>
    CheckUserModel(
      status: json['status'] as bool? ?? false,
      exodim: json['exodim'] as Map<String, dynamic>? ?? const {},
      statusEXodim: json['status_e_xodim'] as bool? ?? false,
    );

Map<String, dynamic> _$CheckUserModelToJson(CheckUserModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'exodim': instance.exodim,
      'status_e_xodim': instance.statusEXodim,
    };

Exodim _$ExodimFromJson(Map<String, dynamic> json) => Exodim(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      photo: json['photo'] as String? ?? "",
      education: json['education'] as String? ?? "",
      nationality: json['nationality'] as String? ?? "",
      phone: json['phone'] as String? ?? "",
      birthPlace: json['birth_place'] as String? ?? "",
      currentPlace: json['current_place'] as String? ?? "",
      positions: json['positions'] as List<dynamic>? ?? const [],
      lastMed: json['last_med'],
    );

Map<String, dynamic> _$ExodimToJson(Exodim instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo': instance.photo,
      'education': instance.education,
      'nationality': instance.nationality,
      'phone': instance.phone,
      'birth_place': instance.birthPlace,
      'current_place': instance.currentPlace,
      'positions': instance.positions,
      'last_med': instance.lastMed,
    };
