// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rec_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecProductModel _$RecProductModelFromJson(Map<String, dynamic> json) =>
    RecProductModel(
      id: json['id'] as int? ?? 0,
      orgProductId: json['org_product_id'] as int? ?? 0,
      product: json['product'] as int? ?? 0,
      qty: json['qty'] as int? ?? 0,
      date: json['date'] as String? ?? "",
      isDeleted: json['is_deleted'] as bool? ?? false,
    );

Map<String, dynamic> _$RecProductModelToJson(RecProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'org_product_id': instance.orgProductId,
      'product': instance.product,
      'qty': instance.qty,
      'date': instance.date,
      'is_deleted': instance.isDeleted,
    };
