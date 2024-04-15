import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/data/models/extra_model.dart';

class ExtraEntity extends Equatable {
  final int id;
  final String partnerOrg;
  final bool productReverse;
  final bool productGroupReverse;
  final String fromDate;
  final String toDate;
  final int limitPerUser;
  final int status;
  final List<int> products;
  final List<int> productGroups;

  const ExtraEntity({
    this.id = 0,
    this.partnerOrg = "",
    this.productReverse = false,
    this.productGroupReverse = false,
    this.fromDate = "",
    this.toDate = "",
    this.limitPerUser = 0,
    this.status = 0,
    this.products = const [],
    this.productGroups = const [],
  });

  @override
  List<Object?> get props => [
        id,
        partnerOrg,
        productReverse,
        productGroupReverse,
        fromDate,
        toDate,
        limitPerUser,
        status,
        products,
        productGroups,
      ];
}

class ExtraConverter
    implements JsonConverter<ExtraEntity, Map<String, dynamic>?> {
  const ExtraConverter();
  @override
  ExtraEntity fromJson(Map<String, dynamic>? json) =>
      ExtraModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(ExtraEntity object) => {};
}
