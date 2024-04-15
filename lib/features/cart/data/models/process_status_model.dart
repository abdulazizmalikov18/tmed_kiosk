import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/process_status_entity.dart';

part 'process_status_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProcessStatusModel extends ProcessStatusEntity {
  const ProcessStatusModel({
    super.id,
    super.name,
    super.flow,
    super.key,
    super.order,
    super.isVisible,
    super.isDefault,
    super.productCount,
  });

  factory ProcessStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ProcessStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessStatusModelToJson(this);
}
