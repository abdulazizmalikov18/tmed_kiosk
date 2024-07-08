// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      file: json['file'] as String? ?? '',
      main: json['main'] as bool? ?? false,
      org: json['org'] ?? '',
      product: (json['product'] as num?)?.toInt() ?? 0,
      status: json['status'] as bool? ?? false,
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'file': instance.file,
      'main': instance.main,
      'status': instance.status,
      'org': instance.org,
      'product': instance.product,
    };
