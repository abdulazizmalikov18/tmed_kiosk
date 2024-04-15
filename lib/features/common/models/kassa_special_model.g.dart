// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kassa_special_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KassaSpecialModel _$KassaSpecialModelFromJson(Map<String, dynamic> json) =>
    KassaSpecialModel(
      id: json['id'] as String? ?? '',
      org: json['org'] == null
          ? const KassaOrgEntity()
          : const KassaOrgConverter()
              .fromJson(json['org'] as Map<String, dynamic>?),
      specCat: json['spec_cat'] == null
          ? const KassaJobEntity()
          : const KassaJobConverter()
              .fromJson(json['spec_cat'] as Map<String, dynamic>?),
      name: json['name'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      job: json['job'] == null
          ? const KassaJobEntity()
          : const KassaJobConverter()
              .fromJson(json['job'] as Map<String, dynamic>?),
      auto: json['auto'] as bool? ?? false,
      locationDesc: json['location_desc'] as String? ?? '',
    );

Map<String, dynamic> _$KassaSpecialModelToJson(KassaSpecialModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'org': const KassaOrgConverter().toJson(instance.org),
      'spec_cat': const KassaJobConverter().toJson(instance.specCat),
      'name': instance.name,
      'lastname': instance.lastname,
      'avatar': instance.avatar,
      'job': const KassaJobConverter().toJson(instance.job),
      'auto': instance.auto,
      'location_desc': instance.locationDesc,
    };
