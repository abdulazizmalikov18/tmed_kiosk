import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/position_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/spec_cat_entity.dart';

part 'position_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PositionModel extends PositionEntity {
  const PositionModel({
    super.id,
    super.createDate,
    super.name,
    super.org,
    super.status,
    super.updateDate,
  });

  factory PositionModel.fromJson(Map<String, dynamic> json) =>
      _$PositionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PositionModelToJson(this);
}
