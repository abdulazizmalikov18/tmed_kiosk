// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyLocationModel _$MyLocationModelFromJson(Map<String, dynamic> json) =>
    MyLocationModel(
      latitude: json['latitude'] as String? ?? "",
      longitude: json['longitude'] as String? ?? "",
    );

Map<String, dynamic> _$MyLocationModelToJson(MyLocationModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
