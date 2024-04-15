// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companiy_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompaniyCategoryModel _$CompaniyCategoryModelFromJson(
        Map<String, dynamic> json) =>
    CompaniyCategoryModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      hideFromOrgs: json['hide_from_orgs'] as bool? ?? false,
      hideFromUsers: json['hide_from_users'] as bool? ?? false,
      image: json['image'] as String? ?? '',
      status: json['status'] as bool? ?? false,
      firstLevelScore: json['first_level_score'] as int? ?? 0,
      levelProgressBy: json['level_progress_by'] as int? ?? 0,
      parent: json['parent'] as int? ?? 0,
    );

Map<String, dynamic> _$CompaniyCategoryModelToJson(
        CompaniyCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'hide_from_orgs': instance.hideFromOrgs,
      'hide_from_users': instance.hideFromUsers,
      'image': instance.image,
      'status': instance.status,
      'first_level_score': instance.firstLevelScore,
      'level_progress_by': instance.levelProgressBy,
      'parent': instance.parent,
    };
