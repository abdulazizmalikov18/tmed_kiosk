import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/models/kassa_org_model.dart';

class KassaOrgEntity extends Equatable {
  final String id;
  final String name;
  final String slugName;
  final String logo;
  final String phone;
  final String operationType;
  final String address;

  const KassaOrgEntity({
    this.id = '',
    this.name = '',
    this.slugName = '',
    this.logo = '',
    this.phone = "",
    this.operationType = "",
    this.address = "",
  });

  @override
  List<Object?> get props => [
        id,
        name,
        slugName,
        logo,
        phone,
        operationType,
        address,
      ];
}

class KassaOrgConverter
    implements JsonConverter<KassaOrgEntity, Map<String, dynamic>?> {
  const KassaOrgConverter();
  @override
  KassaOrgEntity fromJson(Map<String, dynamic>? json) =>
      KassaOrgModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(KassaOrgEntity object) => {};
}
