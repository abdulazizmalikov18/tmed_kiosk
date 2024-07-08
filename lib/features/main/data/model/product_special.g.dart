// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_special.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSpecialModel _$ProductSpecialModelFromJson(Map<String, dynamic> json) =>
    ProductSpecialModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      specialist: json['specialist'] == null
          ? const SpecialistsEntity()
          : const SpecialistsConverter()
              .fromJson(json['specialist'] as Map<String, dynamic>?),
      product: (json['product'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProductSpecialModelToJson(
        ProductSpecialModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'specialist': const SpecialistsConverter().toJson(instance.specialist),
      'product': instance.product,
    };
