// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationModel _$RecommendationModelFromJson(Map<String, dynamic> json) =>
    RecommendationModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      specialist: json['specialist'] == null
          ? const Specialist()
          : Specialist.fromJson(json['specialist'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ProductElement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createDate: json['create_date'] as String? ?? "",
      status: (json['status'] as num?)?.toInt() ?? 0,
      number: (json['number'] as num?)?.toInt() ?? 0,
      qrCode: json['qr_code'] as String? ?? "",
      user: json['user'] as String? ?? "",
      fromUser: json['from_user'] as String? ?? "",
      orderProduct: (json['order_product'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RecommendationModelToJson(
        RecommendationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'specialist': instance.specialist,
      'products': instance.products,
      'create_date': instance.createDate,
      'status': instance.status,
      'number': instance.number,
      'qr_code': instance.qrCode,
      'user': instance.user,
      'from_user': instance.fromUser,
      'order_product': instance.orderProduct,
    };

ProductElement _$ProductElementFromJson(Map<String, dynamic> json) =>
    ProductElement(
      id: (json['id'] as num?)?.toInt() ?? 0,
      orgProductId: json['org_product_id'] as String? ?? "",
      product: json['product'] == null
          ? const ProductProduct()
          : ProductProduct.fromJson(json['product'] as Map<String, dynamic>),
      qty: (json['qty'] as num?)?.toInt() ?? 0,
      date: json['date'] as String? ?? "",
      isDeleted: json['is_deleted'] as bool? ?? false,
      commentary: json['commentary'] as String? ?? "",
    );

Map<String, dynamic> _$ProductElementToJson(ProductElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'org_product_id': instance.orgProductId,
      'product': instance.product,
      'qty': instance.qty,
      'date': instance.date,
      'is_deleted': instance.isDeleted,
      'commentary': instance.commentary,
    };

ProductProduct _$ProductProductFromJson(Map<String, dynamic> json) =>
    ProductProduct(
      id: json['id'] as String? ?? "",
      name: json['name'] as String? ?? "",
      unit: json['unit'] == null
          ? const Unit()
          : Unit.fromJson(json['unit'] as Map<String, dynamic>),
      price: json['price'] == null
          ? const Price()
          : Price.fromJson(json['price'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductProductToJson(ProductProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unit': instance.unit,
      'price': instance.price,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      id: json['id'] as String? ?? "",
      val: (json['val'] as num?)?.toInt() ?? 0,
      currency: json['currency'] as String? ?? "",
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'id': instance.id,
      'val': instance.val,
      'currency': instance.currency,
    };

Unit _$UnitFromJson(Map<String, dynamic> json) => Unit(
      id: json['id'] as String? ?? "",
      name: json['name'] as String? ?? "",
    );

Map<String, dynamic> _$UnitToJson(Unit instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Specialist _$SpecialistFromJson(Map<String, dynamic> json) => Specialist(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? "",
      lastname: json['lastname'] as String? ?? "",
      org: json['org'] as String? ?? "",
      job: json['job'] as String? ?? "",
    );

Map<String, dynamic> _$SpecialistToJson(Specialist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastname': instance.lastname,
      'org': instance.org,
      'job': instance.job,
    };
