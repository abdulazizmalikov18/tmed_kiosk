import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/entity/creator_entity.dart';

part 'creator_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreatorModel extends CreatorEntity {
  const CreatorModel({
    super.id,
    super.name,
    super.lastname,
    super.org,
    super.job,
  });

  factory CreatorModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorModelToJson(this);
}
