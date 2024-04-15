// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountModel _$CreateAccountModelFromJson(Map<String, dynamic> json) =>
    CreateAccountModel(
      access: json['access'] as String? ?? "",
      refresh: json['refresh'] as String? ?? "",
      user: json['user'] == null
          ? const UserAccountEntity()
          : const UserAccountConverter()
              .fromJson(json['user'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$CreateAccountModelToJson(CreateAccountModel instance) =>
    <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
      'user': const UserAccountConverter().toJson(instance.user),
    };
