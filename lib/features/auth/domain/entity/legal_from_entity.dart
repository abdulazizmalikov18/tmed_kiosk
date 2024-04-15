import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/auth/data/model/legal_form_model.dart';

class LegalFormEntity extends Equatable {
  final int id;
  final String name;
  final String short;
  final String description;

  const LegalFormEntity({
    this.id = 0,
    this.name = '',
    this.short = '',
    this.description = '',
  });

  @override
  List<Object?> get props => [
        id,
        name,
        short,
        description,
      ];
}

class LegalFormConverter
    implements JsonConverter<LegalFormEntity, Map<String, dynamic>?> {
  const LegalFormConverter();
  @override
  LegalFormEntity fromJson(Map<String, dynamic>? json) =>
      LegalFormModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(LegalFormEntity object) => {};
}
