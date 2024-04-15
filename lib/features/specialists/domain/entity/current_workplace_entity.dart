import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/specialists/data/model/current_workplace_model.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/spec_cat_entity.dart';

class CurrentWorkplaceEntity extends Equatable {
  final int id;
  @SpecCatConverter()
  final SpecCatEntity type;
  final String value;
  final String createDate;
  final String updateDate;

  const CurrentWorkplaceEntity({
    this.id = 0,
    this.type = const SpecCatEntity(),
    this.value = '',
    this.createDate = '',
    this.updateDate = '',
  });

  @override
  List<Object?> get props => [
        id,
        type,
        value,
        createDate,
        updateDate,
      ];
}

class CurrentWorkplaceConverter
    implements JsonConverter<CurrentWorkplaceEntity, Map<String, dynamic>?> {
  const CurrentWorkplaceConverter();
  @override
  CurrentWorkplaceEntity fromJson(Map<String, dynamic>? json) =>
      CurrentWorkplaceModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(CurrentWorkplaceEntity object) => {};
}
