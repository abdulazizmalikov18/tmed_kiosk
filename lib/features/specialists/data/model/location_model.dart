import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/location_entity.dart';

part 'location_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LocationModel extends LocationEntity {
  const LocationModel({
    super.latitude,
    super.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
