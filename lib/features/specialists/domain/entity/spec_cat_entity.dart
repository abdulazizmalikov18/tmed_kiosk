import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/specialists/data/model/spec_cat_model.dart';

class SpecCatEntity extends Equatable {
  final int id;
  final String name;
  final int specialistCount;

  const SpecCatEntity({
    this.id = 0,
    this.name = '',
    this.specialistCount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        specialistCount,
      ];
}

class SpecCatConverter
    implements JsonConverter<SpecCatEntity, Map<String, dynamic>?> {
  const SpecCatConverter();
  @override
  SpecCatEntity fromJson(Map<String, dynamic>? json) =>
      SpecCatModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(SpecCatEntity object) => {};
}
