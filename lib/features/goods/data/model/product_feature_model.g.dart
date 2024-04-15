// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_feature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductFeatureModel _$ProductFeatureModelFromJson(Map<String, dynamic> json) =>
    ProductFeatureModel(
      id: json['id'] as int? ?? 0,
      feature: json['feature'] == null
          ? const FeatureEntity()
          : const FeatureConverter()
              .fromJson(json['feature'] as Map<String, dynamic>?),
      value: json['value'],
      preparedValue: (json['prepared_value'] as List<dynamic>?)
              ?.map((e) => const PreparedValueConverter()
                  .fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProductFeatureModelToJson(
        ProductFeatureModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'feature': const FeatureConverter().toJson(instance.feature),
      'value': instance.value,
      'prepared_value': instance.preparedValue
          .map(const PreparedValueConverter().toJson)
          .toList(),
    };
