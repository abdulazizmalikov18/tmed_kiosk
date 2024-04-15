import 'package:tmed_kiosk/features/specialists/data/model/specialist_order_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class SpecialistOrderEntity extends Equatable {
  final int id;
  final int orderNumber;
  final int lastOrderNumber;
  final int patientNumber;
  final int lastPatientNumber;
  final int specialist;

  const SpecialistOrderEntity({
    this.id = 0,
    this.orderNumber = 0,
    this.lastOrderNumber = 0,
    this.patientNumber = 0,
    this.lastPatientNumber = 0,
    this.specialist = 0,
  });

  @override
  List<Object?> get props => [
        id,
        orderNumber,
        lastOrderNumber,
        patientNumber,
        lastPatientNumber,
        specialist,
      ];
}

class SpecialistOrderConverter
    implements JsonConverter<SpecialistOrderEntity, Map<String, dynamic>?> {
  const SpecialistOrderConverter();
  @override
  SpecialistOrderEntity fromJson(Map<String, dynamic>? json) =>
      SpecialistOrderModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(SpecialistOrderEntity object) => {};
}
