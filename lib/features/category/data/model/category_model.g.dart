// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      productNumbers: (json['product_numbers'] as num?)?.toInt() ?? 0,
      productExist: json['product_exist'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? false,
      image: json['image'] as String? ?? '',
      createDate: json['create_date'] as String? ?? '',
      org: json['org'] as String? ?? '',
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'product_numbers': instance.productNumbers,
      'product_exist': instance.productExist,
      'org': instance.org,
      'image': instance.image,
      'is_active': instance.isActive,
      'create_date': instance.createDate,
    };
