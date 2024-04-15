import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/models/creator_model.dart';

class CreatorEntity extends Equatable {
  final int id;
  final String name;
  final String lastname;
  final String org;
  final String job;

  const CreatorEntity({
    this.id = 0,
    this.name = '',
    this.lastname = '',
    this.org = '',
    this.job = '',
  });

  @override
  List<Object?> get props => [
        id,
        name,
        lastname,
        org,
        job,
      ];
}

class CreatorConverter
    implements JsonConverter<CreatorEntity, Map<String, dynamic>?> {
  const CreatorConverter();

  @override
  CreatorEntity fromJson(Map<String, dynamic>? json) =>
      CreatorModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(CreatorEntity object) => {};
}
