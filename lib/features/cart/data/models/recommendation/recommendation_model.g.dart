// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationModel _$RecommendationModelFromJson(Map<String, dynamic> json) =>
    RecommendationModel(
      id: json['id'] as int? ?? 0,
      specialist: json['specialist'] == null
          ? const RecSpecialistEntity()
          : const RecSpecialistConverter()
              .fromJson(json['specialist'] as Map<String, dynamic>?),
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => const RecProductConverter()
                  .fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
      createDate: json['create_date'] as String? ?? "",
      status: json['status'] as int? ?? 0,
      user: json['user'] as String? ?? "",
      fromUser: json['from_user'] ?? 0,
      orderProduct: json['order_product'] ?? 0,
    );

Map<String, dynamic> _$RecommendationModelToJson(
        RecommendationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'specialist': const RecSpecialistConverter().toJson(instance.specialist),
      'products':
          instance.products.map(const RecProductConverter().toJson).toList(),
      'create_date': instance.createDate,
      'status': instance.status,
      'user': instance.user,
      'from_user': instance.fromUser,
      'order_product': instance.orderProduct,
    };
