// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companiya_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompaniyaListModel _$CompaniyaListModelFromJson(Map<String, dynamic> json) =>
    CompaniyaListModel(
      id: json['id'] as int? ?? 0,
      legalForm: json['legal_form'] == null
          ? const LegalFormEntity()
          : const LegalFormConverter()
              .fromJson(json['legal_form'] as Map<String, dynamic>?),
      region: json['region'] ?? '',
      category: json['category'] == null
          ? const CompaniyCategoryEntity()
          : const CompaniyCategoryConverter()
              .fromJson(json['category'] as Map<String, dynamic>?),
      name: json['name'] as String? ?? '',
      logo: json['logo'] as String? ?? '',
      juridicName: json['juridic_name'] as String? ?? '',
      slugName: json['slug_name'] as String? ?? '',
      location: json['location'] ?? '',
      phone: json['phone'] ?? '',
      status: json['status'] as int? ?? 0,
      createDate: json['create_date'] as String? ?? '',
      isOfficial: json['is_official'] as bool? ?? false,
      textForPrint: json['text_for_print'] ?? '',
    );

Map<String, dynamic> _$CompaniyaListModelToJson(CompaniyaListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'legal_form': const LegalFormConverter().toJson(instance.legalForm),
      'region': instance.region,
      'category': const CompaniyCategoryConverter().toJson(instance.category),
      'name': instance.name,
      'logo': instance.logo,
      'juridic_name': instance.juridicName,
      'slug_name': instance.slugName,
      'location': instance.location,
      'phone': instance.phone,
      'status': instance.status,
      'create_date': instance.createDate,
      'is_official': instance.isOfficial,
      'text_for_print': instance.textForPrint,
    };
