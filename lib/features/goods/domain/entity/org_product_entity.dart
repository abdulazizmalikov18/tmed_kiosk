import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/data/model/org_product_model.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/group_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/price_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/product_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/product_feature_entity.dart';

class OrgProductEntity extends Equatable {
  final int id;
  final String image360;
  @ProductConverter()
  final ProductEntity product;
  final int status;
  final String barCode;
  final int remains;
  final int vat;
  final int duration;
  final String placeDesc;
  @PriceConverter()
  final List<PriceEntity> prices;
  final String expiryDate;
  final String description;
  final String textCheck;
  @GroupConverter()
  final List<GroupEntity> groups;
  @ProductFeatureConverter()
  final List<ProductFeatureEntity> productFeatures;
  final List<int> specialistIds;

  const OrgProductEntity({
    this.id = 0,
    this.image360 = "",
    this.product = const ProductEntity(),
    this.status = 0,
    this.barCode = '',
    this.remains = 0,
    this.vat = 0,
    this.duration = 0,
    this.placeDesc = '',
    this.textCheck = '',
    this.prices = const [],
    this.expiryDate = '',
    this.groups = const [],
    this.productFeatures = const [],
    this.description = '',
    this.specialistIds = const [],
  });

  @override
  List<Object?> get props => [
        id,
        image360,
        product,
        status,
        barCode,
        remains,
        vat,
        duration,
        placeDesc,
        prices,
        expiryDate,
        groups,
        description,
        productFeatures,
        textCheck,
        specialistIds,
      ];
}

class OrgProductConverter
    implements JsonConverter<OrgProductEntity, Map<String, dynamic>?> {
  const OrgProductConverter();
  @override
  OrgProductEntity fromJson(Map<String, dynamic>? json) =>
      OrgProductModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(OrgProductEntity object) => {};
}
