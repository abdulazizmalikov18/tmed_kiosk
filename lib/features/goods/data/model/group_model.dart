import 'package:tmed_kiosk/features/goods/domain/entity/group_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GroupModel extends GroupEntity {
  const GroupModel({
    super.group,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupModelToJson(this);
}
