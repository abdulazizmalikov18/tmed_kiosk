import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/spec_cat_entity.dart';

part 'spec_cat_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SpecCatModel extends SpecCatEntity {
  const SpecCatModel({
    super.id,
    super.name,
    super.specialistCount,
  });

  factory SpecCatModel.fromJson(Map<String, dynamic> json) =>
      _$SpecCatModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpecCatModelToJson(this);
}
