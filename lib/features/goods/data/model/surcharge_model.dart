import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/surcharge_entity.dart';

part 'surcharge_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SurchargeModel extends SurchargeEntity {
  const SurchargeModel({
    super.id,
    super.org,
    super.desc,
    super.isActive,
    super.type,
    super.value,
  });

  factory SurchargeModel.fromJson(Map<String, dynamic> json) =>
      _$SurchargeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurchargeModelToJson(this);
}
