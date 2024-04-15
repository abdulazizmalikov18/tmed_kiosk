import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/data/model/surcharge_model.dart';

class SurchargeEntity extends Equatable {
  final int id;
  // final Currency currency;
  final String org;
  final String desc;
  final int type;
  final double value;
  final bool isActive;

  const SurchargeEntity({
    this.id = 0,
    this.org = '',
    this.desc = '',
    this.isActive = false,
    this.type = 0,
    this.value = 0,
  });

  @override
  List<Object?> get props => [
        id,
        value,
        desc,
        type,
        org,
        isActive,
      ];
}

class PriceConverter
    implements JsonConverter<SurchargeEntity, Map<String, dynamic>?> {
  const PriceConverter();
  @override
  SurchargeEntity fromJson(Map<String, dynamic>? json) =>
      SurchargeModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(SurchargeEntity object) => {};
}
