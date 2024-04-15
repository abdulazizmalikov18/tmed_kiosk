import 'package:tmed_kiosk/features/common/models/my_job_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class MyJobEntity extends Equatable {
  final String id;
  final String name;

  const MyJobEntity({
    this.id = "",
    this.name = "",
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

class MyJobConverter
    implements JsonConverter<MyJobEntity, Map<String, dynamic>?> {
  const MyJobConverter();
  @override
  MyJobEntity fromJson(Map<String, dynamic>? json) =>
      MyJobModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(MyJobEntity object) => {};
}
