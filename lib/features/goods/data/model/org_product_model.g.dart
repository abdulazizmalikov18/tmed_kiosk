// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgProductModel _$OrgProductModelFromJson(Map<String, dynamic> json) =>
    OrgProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      image360: json['image360'] as String? ?? "",
      product: json['product'] == null
          ? const ProductEntity()
          : const ProductConverter()
              .fromJson(json['product'] as Map<String, dynamic>?),
      status: (json['status'] as num?)?.toInt() ?? 0,
      barCode: json['bar_code'] as String? ?? '',
      remains: (json['remains'] as num?)?.toInt() ?? 0,
      vat: (json['vat'] as num?)?.toInt() ?? 0,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      placeDesc: json['place_desc'] as String? ?? '',
      prices: (json['prices'] as List<dynamic>?)
              ?.map((e) =>
                  const PriceConverter().fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
      expiryDate: json['expiry_date'] as String? ?? '',
      groups: (json['groups'] as List<dynamic>?)
              ?.map((e) =>
                  const GroupConverter().fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
      description: json['description'] as String? ?? '',
      textCheck: json['text_check'] as String? ?? '',
      productFeatures: (json['product_features'] as List<dynamic>?)
              ?.map((e) => const ProductFeatureConverter()
                  .fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
      specialistIds: (json['specialist_ids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OrgProductModelToJson(OrgProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image360': instance.image360,
      'product': const ProductConverter().toJson(instance.product),
      'status': instance.status,
      'bar_code': instance.barCode,
      'remains': instance.remains,
      'vat': instance.vat,
      'duration': instance.duration,
      'place_desc': instance.placeDesc,
      'prices': instance.prices.map(const PriceConverter().toJson).toList(),
      'expiry_date': instance.expiryDate,
      'description': instance.description,
      'text_check': instance.textCheck,
      'groups': instance.groups.map(const GroupConverter().toJson).toList(),
      'product_features': instance.productFeatures
          .map(const ProductFeatureConverter().toJson)
          .toList(),
      'specialist_ids': instance.specialistIds,
    };
