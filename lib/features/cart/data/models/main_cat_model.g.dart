// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_cat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainCatModel _$MainCatModelFromJson(Map<String, dynamic> json) => MainCatModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: json['image'] as String? ?? '',
      parent: (json['parent'] as num?)?.toInt() ?? 0,
      userCount: (json['user_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MainCatModelToJson(MainCatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'parent': instance.parent,
      'user_count': instance.userCount,
    };
