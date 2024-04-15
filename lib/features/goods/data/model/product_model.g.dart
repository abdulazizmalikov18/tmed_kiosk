// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      manufacturer: json['manufacturer'] == null
          ? const SpecCatEntity()
          : const SpecCatConverter()
              .fromJson(json['manufacturer'] as Map<String, dynamic>?),
      type: json['type'] == null
          ? const SpecCatEntity()
          : const SpecCatConverter()
              .fromJson(json['type'] as Map<String, dynamic>?),
      unit: json['unit'] == null
          ? const SpecCatEntity()
          : const SpecCatConverter()
              .fromJson(json['unit'] as Map<String, dynamic>?),
      image: json['image'] == null
          ? const ImageEntity()
          : const ImageConverter()
              .fromJson(json['image'] as Map<String, dynamic>?),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) =>
                  const ImageConverter().fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'manufacturer': const SpecCatConverter().toJson(instance.manufacturer),
      'type': const SpecCatConverter().toJson(instance.type),
      'unit': const SpecCatConverter().toJson(instance.unit),
      'image': const ImageConverter().toJson(instance.image),
      'images': instance.images.map(const ImageConverter().toJson).toList(),
    };
