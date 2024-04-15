import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/data/models/a_region_model.dart';

class ARegionEntity extends Equatable {
  final int id;
  final String name;
  final int status;
  final dynamic type;
  final int userCount;
  final int parent;

  const ARegionEntity({
    this.id = 0,
    this.name = '',
    this.status = 0,
    this.type = 0,
    this.userCount = 0,
    this.parent = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        type,
        userCount,
        parent,
      ];
}

class ARegionConverter
    implements JsonConverter<ARegionEntity, Map<String, dynamic>?> {
  const ARegionConverter();
  @override
  ARegionEntity fromJson(Map<String, dynamic>? json) =>
      ARegionModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(ARegionEntity object) => {};
}
