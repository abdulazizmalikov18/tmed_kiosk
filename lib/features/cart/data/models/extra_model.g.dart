// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraModel _$ExtraModelFromJson(Map<String, dynamic> json) => ExtraModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      partnerOrg: json['partner_org'] as String? ?? "",
      productReverse: json['product_reverse'] as bool? ?? false,
      productGroupReverse: json['product_group_reverse'] as bool? ?? false,
      fromDate: json['from_date'] as String? ?? "",
      toDate: json['to_date'] as String? ?? "",
      limitPerUser: (json['limit_per_user'] as num?)?.toInt() ?? 0,
      status: (json['status'] as num?)?.toInt() ?? 0,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      productGroups: (json['product_groups'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ExtraModelToJson(ExtraModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'partner_org': instance.partnerOrg,
      'product_reverse': instance.productReverse,
      'product_group_reverse': instance.productGroupReverse,
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'limit_per_user': instance.limitPerUser,
      'status': instance.status,
      'products': instance.products,
      'product_groups': instance.productGroups,
    };
