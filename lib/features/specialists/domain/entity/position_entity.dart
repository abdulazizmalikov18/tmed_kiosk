import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/specialists/data/model/position_model.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/spec_cat_entity.dart';

class PositionEntity extends Equatable {
  final int id;
  @SpecCatConverter()
  final SpecCatEntity org;
  final String name;
  final bool status;
  final String createDate;
  final String updateDate;

  const PositionEntity({
    this.id = 0,
    this.org = const SpecCatEntity(),
    this.name = '',
    this.status = false,
    this.createDate = '',
    this.updateDate = '',
  });

  @override
  List<Object?> get props => [
        id,
        org,
        name,
        status,
        createDate,
        updateDate,
      ];
}

class PositionConverter
    implements JsonConverter<PositionEntity, Map<String, dynamic>?> {
  const PositionConverter();
  @override
  PositionEntity fromJson(Map<String, dynamic>? json) =>
      PositionModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(PositionEntity object) => {};
}
