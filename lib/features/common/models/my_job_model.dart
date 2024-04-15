import 'package:tmed_kiosk/features/common/domain/entity/my_job_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_job_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MyJobModel extends MyJobEntity {
  const MyJobModel({
    super.id,
    super.name,
  });

  factory MyJobModel.fromJson(Map<String, dynamic> json) =>
      _$MyJobModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyJobModelToJson(this);
}
