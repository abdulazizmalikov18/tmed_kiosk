import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/data/model/prepared_value_model.dart';

class PreparedValueEntity extends Equatable {
  final int id;
  final String value;
  final int baseFeature;

  const PreparedValueEntity({
    this.id = 0,
    this.value = '',
    this.baseFeature = 0,
  });

  @override
  List<Object?> get props => [
        id,
        value,
        baseFeature,
      ];
}

class PreparedValueConverter
    implements JsonConverter<PreparedValueEntity, Map<String, dynamic>?> {
  const PreparedValueConverter();
  @override
  PreparedValueEntity fromJson(Map<String, dynamic>? json) =>
      PreparedValueModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(PreparedValueEntity object) => {};
}
