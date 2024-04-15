import 'package:tmed_kiosk/features/common/models/my_location.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class MyLocationEntity extends Equatable {
  final String latitude;
  final String longitude;

  const MyLocationEntity({
    this.latitude = "",
    this.longitude = "",
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}

class MyLocationConverter
    implements JsonConverter<MyLocationEntity, Map<String, dynamic>?> {
  const MyLocationConverter();
  @override
  MyLocationEntity fromJson(Map<String, dynamic>? json) =>
      MyLocationModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(MyLocationEntity object) => {};
}
