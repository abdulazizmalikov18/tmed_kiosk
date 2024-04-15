import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/data/models/recommendation/rec_specialist_model.dart';

class RecSpecialistEntity extends Equatable {
  final int id;
  final String name;
  final String lastname;
  final String org;
  final String job;

  const RecSpecialistEntity({
    this.id = 0,
    this.name = "",
    this.lastname = "",
    this.org = "",
    this.job = "",
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

class RecSpecialistConverter
    implements JsonConverter<RecSpecialistEntity, Map<String, dynamic>?> {
  const RecSpecialistConverter();
  @override
  RecSpecialistEntity fromJson(Map<String, dynamic>? json) =>
      RecSpecialistModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(RecSpecialistEntity object) => {};
}
