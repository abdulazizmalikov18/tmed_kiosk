import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/recommendation/rec_specialist_entity.dart';

part 'rec_specialist_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RecSpecialistModel extends RecSpecialistEntity {
  const RecSpecialistModel({
    super.id,
    super.name,
    super.lastname,
    super.org,
    super.job,
  });

  factory RecSpecialistModel.fromJson(Map<String, dynamic> json) =>
      _$RecSpecialistModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecSpecialistModelToJson(this);
}
