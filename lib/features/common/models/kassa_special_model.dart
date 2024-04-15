import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/entity/kassa_job_entity.dart';
import 'package:tmed_kiosk/features/common/entity/kassa_org_entity.dart';
import 'package:tmed_kiosk/features/common/entity/kassa_special_entity.dart';

part 'kassa_special_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class KassaSpecialModel extends KassaSpecialEntity {
  const KassaSpecialModel({
    super.id,
    super.org,
    super.specCat,
    super.name,
    super.lastname,
    super.avatar,
    super.job,
    super.auto,
    super.locationDesc,
  });

  factory KassaSpecialModel.fromJson(Map<String, dynamic> json) =>
      _$KassaSpecialModelFromJson(json);

  Map<String, dynamic> toJson() => _$KassaSpecialModelToJson(this);
}
