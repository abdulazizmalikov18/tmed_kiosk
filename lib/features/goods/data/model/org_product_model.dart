import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/group_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/price_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/product_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/product_feature_entity.dart';

part 'org_product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrgProductModel extends OrgProductEntity {
  const OrgProductModel({
    super.id,
    super.product,
    super.status,
    super.barCode,
    super.remains,
    super.vat,
    super.duration,
    super.placeDesc,
    super.prices,
    super.expiryDate,
    super.groups,
    super.description,
    super.textCheck,
    super.productFeatures,
    super.specialistIds,
  });

  factory OrgProductModel.fromJson(Map<String, dynamic> json) =>
      _$OrgProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrgProductModelToJson(this);
}
