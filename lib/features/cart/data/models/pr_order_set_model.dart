import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/pr_order_set_entity.dart';

part 'pr_order_set_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PrOrderSetModel extends PrOrderSetEntity {
  const PrOrderSetModel({
    // super.id,
    super.product,
    super.name,
    super.qty,
    super.cost,
    super.fullCost,
    super.surcharge,
    // super.meetDate,
    // super.expectedEndDate,
    // super.responsible,
    super.image,
  });

  factory PrOrderSetModel.fromJson(Map<String, dynamic> json) =>
      _$PrOrderSetModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrOrderSetModelToJson(this);
}
