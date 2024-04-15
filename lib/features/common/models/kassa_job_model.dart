import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/entity/kassa_job_entity.dart';

part 'kassa_job_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class KassaJobModel extends KassaJobEntity {
  const KassaJobModel({
    super.id,
    super.name,
  });

  factory KassaJobModel.fromJson(Map<String, dynamic> json) =>
      _$KassaJobModelFromJson(json);

  Map<String, dynamic> toJson() => _$KassaJobModelToJson(this);
}
