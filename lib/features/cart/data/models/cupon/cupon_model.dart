import 'package:json_annotation/json_annotation.dart';

part 'cupon_model.g.dart';

@JsonSerializable()
class CuponModel {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "partner")
  final List<Partner> partner;
  @JsonKey(name: "organization")
  final Organization organization;
  @JsonKey(name: "product_discount")
  final int productDiscount;
  @JsonKey(name: "description")
  final dynamic description;
  @JsonKey(name: "from_date")
  final String fromDate;
  @JsonKey(name: "to_date")
  final String toDate;
  @JsonKey(name: "limit_per_user")
  final int limitPerUser;
  @JsonKey(name: "type")
  final int type;
  @JsonKey(name: "image")
  final dynamic image;
  @JsonKey(name: "is_active")
  final bool isActive;

  const CuponModel({
    this.id = 0,
    this.title = "",
    this.partner = const [],
    this.organization = const Organization(),
    this.productDiscount = 0,
    this.description = "",
    this.fromDate = "",
    this.toDate = "",
    this.limitPerUser = 0,
    this.type = 0,
    this.image = "",
    this.isActive = false,
  });

  factory CuponModel.fromJson(Map<String, dynamic> json) =>
      _$CuponModelFromJson(json);

  Map<String, dynamic> toJson() => _$CuponModelToJson(this);
}

@JsonSerializable()
class Organization {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "slug_name")
  final String slugName;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "logo")
  final String logo;

  const Organization({
    this.id = 0,
    this.slugName = "",
    this.name = "",
    this.logo = "",
  });

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}

@JsonSerializable()
class Partner {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "partner_org")
  final String partnerOrg;
  @JsonKey(name: "partner_org_name")
  final dynamic partnerOrgName;
  @JsonKey(name: "max_price_limit")
  final dynamic maxPriceLimit;
  @JsonKey(name: "status")
  final int status;
  @JsonKey(name: "groups_count")
  final int groupsCount;
  @JsonKey(name: "products_count")
  final int productsCount;
  @JsonKey(name: "groups")
  final List<Group> groups;

  const Partner({
    this.id = 0,
    this.partnerOrg = "",
    this.partnerOrgName = "",
    this.maxPriceLimit = "",
    this.status = 0,
    this.groupsCount = 0,
    this.productsCount = 0,
    this.groups = const [],
  });

  factory Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerToJson(this);
}

@JsonSerializable()
class Group {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "all")
  final bool all;
  @JsonKey(name: "products")
  final List<int> products;

  Group({
    this.id = 0,
    this.all = false,
    this.products = const [],
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
