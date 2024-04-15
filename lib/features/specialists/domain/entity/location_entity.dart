import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/specialists/data/model/location_model.dart';

class LocationEntity extends Equatable {
  final double latitude;
  final double longitude;

  const LocationEntity({
    this.latitude = 41.311081,
    this.longitude = 69.240562,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}

class LocationConverter
    implements JsonConverter<LocationEntity, Map<String, dynamic>?> {
  const LocationConverter();
  @override
  LocationEntity fromJson(Map<String, dynamic>? json) =>
      LocationModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(LocationEntity object) => {};
}
