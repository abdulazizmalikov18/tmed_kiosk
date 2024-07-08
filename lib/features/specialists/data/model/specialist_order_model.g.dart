// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialist_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialistOrderModel _$SpecialistOrderModelFromJson(
        Map<String, dynamic> json) =>
    SpecialistOrderModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      orderNumber: (json['order_number'] as num?)?.toInt() ?? 0,
      lastOrderNumber: (json['last_order_number'] as num?)?.toInt() ?? 0,
      patientNumber: (json['patient_number'] as num?)?.toInt() ?? 0,
      lastPatientNumber: (json['last_patient_number'] as num?)?.toInt() ?? 0,
      specialist: (json['specialist'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SpecialistOrderModelToJson(
        SpecialistOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'last_order_number': instance.lastOrderNumber,
      'patient_number': instance.patientNumber,
      'last_patient_number': instance.lastPatientNumber,
      'specialist': instance.specialist,
    };
