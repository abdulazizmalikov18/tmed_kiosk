// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CuponModel _$CuponModelFromJson(Map<String, dynamic> json) => CuponModel(
      id: json['id'] as int? ?? 0,
      extra: json['extra'] == null
          ? const ExtraEntity()
          : const ExtraConverter()
              .fromJson(json['extra'] as Map<String, dynamic>?),
      organization: json['organization'],
      title: json['title'] as String? ?? "",
      org: json['org'] as String? ?? "",
      user: json['user'] as String? ?? "",
      productDiscount: (json['product_discount'] as num?)?.toDouble() ?? 0,
      backgroundColor: json['background_color'] as String? ?? "",
      backgroundImage: json['background_image'] as String? ?? "",
      date: json['date'] as String? ?? "",
    );

Map<String, dynamic> _$CuponModelToJson(CuponModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'extra': const ExtraConverter().toJson(instance.extra),
      'organization': instance.organization,
      'title': instance.title,
      'org': instance.org,
      'user': instance.user,
      'product_discount': instance.productDiscount,
      'background_color': instance.backgroundColor,
      'background_image': instance.backgroundImage,
      'date': instance.date,
    };
