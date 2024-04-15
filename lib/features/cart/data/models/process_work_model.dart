import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/process_work_entity.dart';

part 'process_work_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProcessWorkModel extends ProcessWorkEntity {
  const ProcessWorkModel({
    super.id,
    super.name,
    super.description,
    super.creator,
    super.org,
    super.active,
  });

  factory ProcessWorkModel.fromJson(Map<String, dynamic> json) =>
      _$ProcessWorkModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessWorkModelToJson(this);
}
