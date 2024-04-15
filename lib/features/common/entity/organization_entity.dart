import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/models/organization_model.dart';

class OrganizationEntity extends Equatable {
  final String slugName;
  final String name;

  const OrganizationEntity({
    this.slugName = '',
    this.name = '',
  });

  @override
  List<Object?> get props => [slugName, name];
}

class OrganizationConverter
    implements JsonConverter<OrganizationEntity, Map<String, dynamic>?> {
  const OrganizationConverter();

  @override
  OrganizationEntity fromJson(Map<String, dynamic>? json) =>
      OrganizationModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(OrganizationEntity object) => {};
}
