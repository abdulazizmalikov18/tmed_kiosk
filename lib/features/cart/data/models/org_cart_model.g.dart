// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgCartModel _$OrgCartModelFromJson(Map<String, dynamic> json) => OrgCartModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      org: json['org'] as String? ?? '',
      user: json['user'] ?? '',
      creator: json['creator'] as String? ?? '',
      createDate: json['create_date'] as String? ?? '',
    );

Map<String, dynamic> _$OrgCartModelToJson(OrgCartModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'org': instance.org,
      'user': instance.user,
      'creator': instance.creator,
      'create_date': instance.createDate,
    };
