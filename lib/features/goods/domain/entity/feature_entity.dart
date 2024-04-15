import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/data/model/feature_model.dart';

class FeatureEntity extends Equatable {
  final int id;
  final int requiredFormat;
  final bool multiValues;
  final bool required;
  final String name;

  const FeatureEntity({
    this.name = '',
    this.id = 0,
    this.requiredFormat = 0,
    this.multiValues = false,
    this.required = false,
  });

  @override
  List<Object?> get props => [
        name,
        id,
        requiredFormat,
        multiValues,
        required,
      ];
}

class FeatureConverter
    implements JsonConverter<FeatureEntity, Map<String, dynamic>?> {
  const FeatureConverter();
  @override
  FeatureEntity fromJson(Map<String, dynamic>? json) =>
      FeatureModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(FeatureEntity object) => {};
}
