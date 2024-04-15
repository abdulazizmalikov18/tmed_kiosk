import 'package:tmed_kiosk/features/common/domain/entity/my_job_entity.dart';
import 'package:tmed_kiosk/features/common/domain/entity/my_location_entity.dart';
import 'package:tmed_kiosk/features/common/domain/entity/specialist_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/entity/kassa_org_entity.dart';

part 'specialist.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MySpecialistModel extends MySpecialist {
  const MySpecialistModel({
    super.id,
    super.org,
    super.specCat,
    super.name,
    super.lastname,
    super.job,
    super.auto,
    super.avatar,
    super.locationDesc,
    super.location,
  });

  factory MySpecialistModel.fromJson(Map<String, dynamic> json) =>
      _$MySpecialistModelFromJson(json);

  Map<String, dynamic> toJson() => _$MySpecialistModelToJson(this);
}
