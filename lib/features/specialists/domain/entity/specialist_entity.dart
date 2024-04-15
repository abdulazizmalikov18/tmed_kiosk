import 'package:tmed_kiosk/features/common/entity/kassa_org_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/specialist_order_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/specialists/data/model/specialist_model.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/current_workplace_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/job_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/location_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/position_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/spec_cat_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/today_time_table_entity.dart';

class SpecialistsEntity extends Equatable {
  final int id;
  final String name;
  final String lastname;
  final String avatar;
  final String phone;
  @CurrentWorkplaceConverter()
  final List<CurrentWorkplaceEntity> currentWorkplace;
  final String user;
  @KassaOrgConverter()
  final KassaOrgEntity org;
  @JobConverter()
  final JobEntity job;
  @SpecCatConverter()
  final SpecCatEntity specCat;
  @SpecialistOrderConverter()
  final List<SpecialistOrderEntity> specialistOrders;
  final bool isWorking;
  final bool isCatHead;
  final dynamic operatingMode;
  @PositionConverter()
  final PositionEntity position;
  final bool autoMode;
  final bool accepted;
  @TodayTimetableConverter()
  final TodayTimetableEntity todayTimetable;
  final String experience;
  final String bio;
  @LocationConverter()
  final LocationEntity location;
  final int orderCount;

  const SpecialistsEntity({
    this.id = 0,
    this.name = '',
    this.lastname = '',
    this.avatar = '',
    this.phone = '',
    this.org = const KassaOrgEntity(),
    this.currentWorkplace = const [],
    this.user = '',
    this.job = const JobEntity(),
    this.specCat = const SpecCatEntity(),
    this.specialistOrders = const [],
    this.isWorking = false,
    this.isCatHead = false,
    this.operatingMode = '',
    this.position = const PositionEntity(),
    this.autoMode = false,
    this.accepted = false,
    this.todayTimetable = const TodayTimetableEntity(),
    this.experience = '',
    this.bio = '',
    this.location = const LocationEntity(),
    this.orderCount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        lastname,
        avatar,
        phone,
        currentWorkplace,
        user,
        job,
        org,
        specCat,
        specialistOrders,
        isWorking,
        isCatHead,
        operatingMode,
        position,
        autoMode,
        accepted,
        todayTimetable,
        experience,
        bio,
        location,
        orderCount,
      ];
}

class SpecialistsConverter
    implements JsonConverter<SpecialistsEntity, Map<String, dynamic>?> {
  const SpecialistsConverter();
  @override
  SpecialistsEntity fromJson(Map<String, dynamic>? json) =>
      SpecialistsModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(SpecialistsEntity object) => {};
}
