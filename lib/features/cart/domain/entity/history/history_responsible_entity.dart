import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/data/models/history/history_reponsible_model.dart';

class HistoryResponsibleEntity extends Equatable {
  final int id;
  final String name;
  final String lastname;
  final String org;
  final String job;

  const HistoryResponsibleEntity({
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

class HistoryResponsibleConverter
    implements JsonConverter<HistoryResponsibleEntity, Map<String, dynamic>?> {
  const HistoryResponsibleConverter();
  @override
  HistoryResponsibleEntity fromJson(Map<String, dynamic>? json) =>
      HistoryResponsibleModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(HistoryResponsibleEntity object) => {};
}
