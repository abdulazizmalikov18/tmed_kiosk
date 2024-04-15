import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/current_workplace_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/spec_cat_entity.dart';

part 'current_workplace_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CurrentWorkplaceModel extends CurrentWorkplaceEntity {
  const CurrentWorkplaceModel({
    super.id,
    super.createDate,
    super.type,
    super.updateDate,
    super.value,
  });

  factory CurrentWorkplaceModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentWorkplaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWorkplaceModelToJson(this);
}
