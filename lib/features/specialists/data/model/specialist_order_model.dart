import 'package:tmed_kiosk/features/specialists/domain/entity/specialist_order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'specialist_order_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SpecialistOrderModel extends SpecialistOrderEntity {
  const SpecialistOrderModel({
    super.id,
    super.orderNumber,
    super.lastOrderNumber,
    super.patientNumber,
    super.lastPatientNumber,
    super.specialist,
  });

  factory SpecialistOrderModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialistOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialistOrderModelToJson(this);
}
