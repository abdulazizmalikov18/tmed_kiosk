import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/extra_entity.dart';

part 'extra_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ExtraModel extends ExtraEntity {
  const ExtraModel({
    super.id,
    super.partnerOrg,
    super.productReverse,
    super.productGroupReverse,
    super.fromDate,
    super.toDate,
    super.limitPerUser,
    super.status,
    super.products,
    super.productGroups,
  });

  factory ExtraModel.fromJson(Map<String, dynamic> json) =>
      _$ExtraModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraModelToJson(this);
}
