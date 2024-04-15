import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/prepared_value_entity.dart';

part 'prepared_value_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PreparedValueModel extends PreparedValueEntity {
  const PreparedValueModel({
    super.id,
    super.value,
    super.baseFeature,
  });

  factory PreparedValueModel.fromJson(Map<String, dynamic> json) =>
      _$PreparedValueModelFromJson(json);

  Map<String, dynamic> toJson() => _$PreparedValueModelToJson(this);
}
