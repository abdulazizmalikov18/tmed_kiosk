// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CuponModel _$CuponModelFromJson(Map<String, dynamic> json) => CuponModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? "",
      partner: (json['partner'] as List<dynamic>?)
              ?.map((e) => Partner.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      organization: json['organization'] == null
          ? const Organization()
          : Organization.fromJson(json['organization'] as Map<String, dynamic>),
      productDiscount: (json['product_discount'] as num?)?.toInt() ?? 0,
      description: json['description'] ?? "",
      fromDate: json['from_date'] as String? ?? "",
      toDate: json['to_date'] as String? ?? "",
      limitPerUser: (json['limit_per_user'] as num?)?.toInt() ?? 0,
      type: (json['type'] as num?)?.toInt() ?? 0,
      image: json['image'] ?? "",
      isActive: json['is_active'] as bool? ?? false,
    );

Map<String, dynamic> _$CuponModelToJson(CuponModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'partner': instance.partner,
      'organization': instance.organization,
      'product_discount': instance.productDiscount,
      'description': instance.description,
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'limit_per_user': instance.limitPerUser,
      'type': instance.type,
      'image': instance.image,
      'is_active': instance.isActive,
    };

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization(
      id: (json['id'] as num?)?.toInt() ?? 0,
      slugName: json['slug_name'] as String? ?? "",
      name: json['name'] as String? ?? "",
      logo: json['logo'] as String? ?? "",
    );

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug_name': instance.slugName,
      'name': instance.name,
      'logo': instance.logo,
    };

Partner _$PartnerFromJson(Map<String, dynamic> json) => Partner(
      id: (json['id'] as num?)?.toInt() ?? 0,
      partnerOrg: json['partner_org'] as String? ?? "",
      partnerOrgName: json['partner_org_name'] ?? "",
      maxPriceLimit: json['max_price_limit'] ?? "",
      status: (json['status'] as num?)?.toInt() ?? 0,
      groupsCount: (json['groups_count'] as num?)?.toInt() ?? 0,
      productsCount: (json['products_count'] as num?)?.toInt() ?? 0,
      groups: (json['groups'] as List<dynamic>?)
              ?.map((e) => Group.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PartnerToJson(Partner instance) => <String, dynamic>{
      'id': instance.id,
      'partner_org': instance.partnerOrg,
      'partner_org_name': instance.partnerOrgName,
      'max_price_limit': instance.maxPriceLimit,
      'status': instance.status,
      'groups_count': instance.groupsCount,
      'products_count': instance.productsCount,
      'groups': instance.groups,
    };

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      id: (json['id'] as num?)?.toInt() ?? 0,
      all: json['all'] as bool? ?? false,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'all': instance.all,
      'products': instance.products,
    };
