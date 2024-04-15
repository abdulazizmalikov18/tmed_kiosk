import 'package:tmed_kiosk/features/common/domain/entity/my_location_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_location.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MyLocationModel extends MyLocationEntity {
  const MyLocationModel({
    super.latitude,
    super.longitude,
  });

  factory MyLocationModel.fromJson(Map<String, dynamic> json) =>
      _$MyLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyLocationModelToJson(this);
}
