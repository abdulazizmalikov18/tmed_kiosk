import 'package:json_annotation/json_annotation.dart';

part 'recommendation_model.g.dart';

@JsonSerializable()
class RecommendationModel {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "specialist")
  final Specialist specialist;
  @JsonKey(name: "products")
  final List<ProductElement> products;
  @JsonKey(name: "create_date")
  final String createDate;
  @JsonKey(name: "status")
  final int status;
  @JsonKey(name: "number")
  final int number;
  @JsonKey(name: "qr_code")
  final String qrCode;
  @JsonKey(name: "user")
  final String user;
  @JsonKey(name: "from_user")
  final String fromUser;
  @JsonKey(name: "order_product")
  final int orderProduct;

  RecommendationModel({
    this.id = 0,
    this.specialist = const Specialist(),
    this.products = const [],
    this.createDate = "",
    this.status = 0,
    this.number = 0,
    this.qrCode = "",
    this.user = "",
    this.fromUser = "",
    this.orderProduct = 0,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationModelToJson(this);
}

@JsonSerializable()
class ProductElement {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "org_product_id")
  final String orgProductId;
  @JsonKey(name: "product")
  final ProductProduct product;
  @JsonKey(name: "qty")
  final int qty;
  @JsonKey(name: "date")
  final String date;
  @JsonKey(name: "is_deleted")
  final bool isDeleted;
  @JsonKey(name: "commentary")
  final String commentary;

  ProductElement({
    this.id = 0,
    this.orgProductId = "",
    this.product = const ProductProduct(),
    this.qty = 0,
    this.date = "",
    this.isDeleted = false,
    this.commentary = "",
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) =>
      _$ProductElementFromJson(json);

  Map<String, dynamic> toJson() => _$ProductElementToJson(this);
}

@JsonSerializable()
class ProductProduct {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "unit")
  final Unit unit;
  @JsonKey(name: "price")
  final Price price;

  const ProductProduct({
    this.id = "",
    this.name = "",
    this.unit = const Unit(),
    this.price = const Price(),
  });

  factory ProductProduct.fromJson(Map<String, dynamic> json) =>
      _$ProductProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductProductToJson(this);
}

@JsonSerializable()
class Price {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "val")
  final int val;
  @JsonKey(name: "currency")
  final String currency;

  const Price({
    this.id = "",
    this.val = 0,
    this.currency = "",
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable()
class Unit {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;

  const Unit({
    this.id = "",
    this.name = "",
  });

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  Map<String, dynamic> toJson() => _$UnitToJson(this);
}

@JsonSerializable()
class Specialist {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "lastname")
  final String lastname;
  @JsonKey(name: "org")
  final String org;
  @JsonKey(name: "job")
  final String job;

  const Specialist({
    this.id = 0,
    this.name = "",
    this.lastname = "",
    this.org = "",
    this.job = "",
  });

  factory Specialist.fromJson(Map<String, dynamic> json) =>
      _$SpecialistFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialistToJson(this);
}
