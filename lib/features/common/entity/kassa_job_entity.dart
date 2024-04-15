import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/models/kassa_job_model.dart';

class KassaJobEntity extends Equatable {
  final String id;
  final String name;

  const KassaJobEntity({
    this.id = '',
    this.name = '',
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

class KassaJobConverter
    implements JsonConverter<KassaJobEntity, Map<String, dynamic>?> {
  const KassaJobConverter();
  @override
  KassaJobEntity fromJson(Map<String, dynamic>? json) =>
      KassaJobModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(KassaJobEntity object) => {};
}
