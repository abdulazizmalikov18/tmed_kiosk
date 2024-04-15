// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersModel _$OrdersModelFromJson(Map<String, dynamic> json) => OrdersModel(
      id: json['id'] as String? ?? '',
      number: json['number'] as int? ?? 0,
      qrCode: json['qr_code'] as String? ?? '',
      clientComment: json['client_comment'] as String? ?? '',
      user: json['user'] == null
          ? const OrderUserEntity()
          : const OrderUserConverter().fromJson(json['user'] as Map<String, dynamic>?),
      status: json['status'] as int? ?? 0,
      rates: json['rates'] ?? '',
      payment: json['payment'] as int? ?? 0,
      paymentStatus: json['payment_status'] as int? ?? 0,
      prepaidAmount: (json['prepaid_amount'] as num?)?.toDouble() ?? 0,
      totalCost: (json['total_cost'] as num?)?.toDouble() ?? 0,
      deviceId: json['device_id'] ?? '',
      specsComment: json['specs_comment'] as String? ?? '',
      productNumber: json['product_number'] as int? ?? 0,
      insertedValue: (json['inserted_value'] as num?)?.toDouble() ?? 0,
      creator: json['creator'] == null
          ? const CreatorEntity()
          : const CreatorConverter().fromJson(json['creator'] as Map<String, dynamic>?),
      createDate: json['create_date'] as String? ?? '',
      finishDate: json['finish_date'] as String? ?? '',
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => const OrderProductConverter().fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
      meetAddress: json['meet_address'],
      organization: json['organization'] == null
          ? const OrganizationEntity()
          : const OrganizationConverter().fromJson(json['organization'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$OrdersModelToJson(OrdersModel instance) => <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'qr_code': instance.qrCode,
      'organization': const OrganizationConverter().toJson(instance.organization),
      'meet_address': instance.meetAddress,
      'client_comment': instance.clientComment,
      'user': const OrderUserConverter().toJson(instance.user),
      'status': instance.status,
      'rates': instance.rates,
      'payment': instance.payment,
      'payment_status': instance.paymentStatus,
      'prepaid_amount': instance.prepaidAmount,
      'total_cost': instance.totalCost,
      'device_id': instance.deviceId,
      'specs_comment': instance.specsComment,
      'product_number': instance.productNumber,
      'inserted_value': instance.insertedValue,
      'creator': const CreatorConverter().toJson(instance.creator),
      'create_date': instance.createDate,
      'finish_date': instance.finishDate,
      'products': instance.products.map(const OrderProductConverter().toJson).toList(),
    };
