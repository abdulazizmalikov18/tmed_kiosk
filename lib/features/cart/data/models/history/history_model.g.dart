// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      order: json['order'] == null
          ? const HistoryOrderEntity()
          : const HistoryOrderConverter()
              .fromJson(json['order'] as Map<String, dynamic>?),
      cost: (json['cost'] as num?)?.toDouble() ?? 0,
      fullCost: (json['full_cost'] as num?)?.toDouble() ?? 0,
      vat: json['vat'] as int? ?? 0,
      coupon: json['coupon'] ?? 0,
      surcharge: (json['surcharge'] as num?)?.toDouble() ?? 0,
      currentWorkState: json['current_work_state'] == null
          ? const HistoryCurrentWorkStateEntity()
          : const HistoryCurrentWorkStateConverter()
              .fromJson(json['current_work_state'] as Map<String, dynamic>?),
      unit: json['unit'] == null
          ? const HistoryUnitEntity()
          : const HistoryUnitConverter()
              .fromJson(json['unit'] as Map<String, dynamic>?),
      meetDate: json['meet_date'] as String? ?? "",
      responsible: json['responsible'] == null
          ? const HistoryResponsibleEntity()
          : const HistoryResponsibleConverter()
              .fromJson(json['responsible'] as Map<String, dynamic>?),
      discountType: json['discount_type'] as String? ?? "",
      queueNumber: json['queue_number'] as int? ?? 0,
    );

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'order': const HistoryOrderConverter().toJson(instance.order),
      'cost': instance.cost,
      'full_cost': instance.fullCost,
      'vat': instance.vat,
      'coupon': instance.coupon,
      'surcharge': instance.surcharge,
      'current_work_state': const HistoryCurrentWorkStateConverter()
          .toJson(instance.currentWorkState),
      'unit': const HistoryUnitConverter().toJson(instance.unit),
      'meet_date': instance.meetDate,
      'responsible':
          const HistoryResponsibleConverter().toJson(instance.responsible),
      'discount_type': instance.discountType,
      'queue_number': instance.queueNumber,
    };
