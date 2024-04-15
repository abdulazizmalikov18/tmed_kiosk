import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/job_entity.dart';

part 'job_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class JobModel extends JobEntity {
  const JobModel({
    super.id,
    super.name,
    super.description,
    super.hideFromOrgs,
    super.hideFromUsers,
    super.image,
    super.status,
    super.firstLevelScore,
    super.levelProgressBy,
    super.parent,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobModelToJson(this);
}
