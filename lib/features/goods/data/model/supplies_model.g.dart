// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplies_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuppliesModel _$SuppliesModelFromJson(Map<String, dynamic> json) =>
    SuppliesModel(
      id: json['id'] as int? ?? 0,
      quantity: json['quantity'] as int? ?? 0,
      remains: json['remains'] as int? ?? 0,
      expiryDate: json['expiry_date'] as String? ?? '',
      purchasePrice: (json['purchase_price'] as num?)?.toDouble() ?? 0,
      supply: json['supply'] as int? ?? 0,
      product: json['product'] as int? ?? 0,
      currency: json['currency'] as String? ?? '',
    );

Map<String, dynamic> _$SuppliesModelToJson(SuppliesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'remains': instance.remains,
      'expiry_date': instance.expiryDate,
      'purchase_price': instance.purchasePrice,
      'supply': instance.supply,
      'product': instance.product,
      'currency': instance.currency,
    };
