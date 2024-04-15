// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialistsModel _$SpecialistsModelFromJson(Map<String, dynamic> json) =>
    SpecialistsModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      org: json['org'] == null
          ? const KassaOrgEntity()
          : const KassaOrgConverter()
              .fromJson(json['org'] as Map<String, dynamic>?),
      currentWorkplace: (json['current_workplace'] as List<dynamic>?)
              ?.map((e) => const CurrentWorkplaceConverter()
                  .fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
      user: json['user'] as String? ?? '',
      job: json['job'] == null
          ? const JobEntity()
          : const JobConverter().fromJson(json['job'] as Map<String, dynamic>?),
      specCat: json['spec_cat'] == null
          ? const SpecCatEntity()
          : const SpecCatConverter()
              .fromJson(json['spec_cat'] as Map<String, dynamic>?),
      specialistOrders: (json['specialist_orders'] as List<dynamic>?)
              ?.map((e) => const SpecialistOrderConverter()
                  .fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
      isWorking: json['is_working'] as bool? ?? false,
      isCatHead: json['is_cat_head'] as bool? ?? false,
      operatingMode: json['operating_mode'] ?? '',
      position: json['position'] == null
          ? const PositionEntity()
          : const PositionConverter()
              .fromJson(json['position'] as Map<String, dynamic>?),
      autoMode: json['auto_mode'] as bool? ?? false,
      accepted: json['accepted'] as bool? ?? false,
      todayTimetable: json['today_timetable'] == null
          ? const TodayTimetableEntity()
          : const TodayTimetableConverter()
              .fromJson(json['today_timetable'] as Map<String, dynamic>?),
      experience: json['experience'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      location: json['location'] == null
          ? const LocationEntity()
          : const LocationConverter()
              .fromJson(json['location'] as Map<String, dynamic>?),
      orderCount: json['order_count'] as int? ?? 0,
    );

Map<String, dynamic> _$SpecialistsModelToJson(SpecialistsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastname': instance.lastname,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'current_workplace': instance.currentWorkplace
          .map(const CurrentWorkplaceConverter().toJson)
          .toList(),
      'user': instance.user,
      'org': const KassaOrgConverter().toJson(instance.org),
      'job': const JobConverter().toJson(instance.job),
      'spec_cat': const SpecCatConverter().toJson(instance.specCat),
      'specialist_orders': instance.specialistOrders
          .map(const SpecialistOrderConverter().toJson)
          .toList(),
      'is_working': instance.isWorking,
      'is_cat_head': instance.isCatHead,
      'operating_mode': instance.operatingMode,
      'position': const PositionConverter().toJson(instance.position),
      'auto_mode': instance.autoMode,
      'accepted': instance.accepted,
      'today_timetable':
          const TodayTimetableConverter().toJson(instance.todayTimetable),
      'experience': instance.experience,
      'bio': instance.bio,
      'location': const LocationConverter().toJson(instance.location),
      'order_count': instance.orderCount,
    };
