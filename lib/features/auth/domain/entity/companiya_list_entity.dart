import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/auth/data/model/companiya_list_model.dart';
import 'package:tmed_kiosk/features/auth/domain/entity/companiy_category_entity.dart';
import 'package:tmed_kiosk/features/auth/domain/entity/legal_from_entity.dart';

class CompaniyaListEntity extends Equatable {
  final int id;
  @LegalFormConverter()
  final LegalFormEntity legalForm;
  final dynamic region;
  @CompaniyCategoryConverter()
  final CompaniyCategoryEntity category;
  final String name;
  final String logo;
  final String juridicName;
  final String slugName;
  final dynamic location;
  final dynamic phone;
  final int status;
  final String createDate;
  final bool isOfficial;
  final dynamic textForPrint;

  const CompaniyaListEntity({
    this.id = 0,
    this.legalForm = const LegalFormEntity(),
    this.region = '',
    this.category = const CompaniyCategoryEntity(),
    this.name = '',
    this.logo = '',
    this.juridicName = '',
    this.slugName = '',
    this.location = '',
    this.phone = '',
    this.status = 0,
    this.createDate = '',
    this.isOfficial = false,
    this.textForPrint = '',
  });

  @override
  List<Object?> get props => [
        id,
        legalForm,
        region,
        category,
        name,
        logo,
        juridicName,
        slugName,
        location,
        phone,
        status,
        createDate,
        isOfficial,
        textForPrint,
      ];
}

class CompaniyaListConverter
    implements JsonConverter<CompaniyaListEntity, Map<String, dynamic>?> {
  const CompaniyaListConverter();
  @override
  CompaniyaListEntity fromJson(Map<String, dynamic>? json) =>
      CompaniyaListModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(CompaniyaListEntity object) => {};
}
