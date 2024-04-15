import 'package:tmed_kiosk/features/common/entity/kassa_org_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/specialist_order_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/current_workplace_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/job_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/location_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/position_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/spec_cat_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/specialist_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/today_time_table_entity.dart';

part 'specialist_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SpecialistsModel extends SpecialistsEntity {
  const SpecialistsModel({
    super.id,
    super.name,
    super.lastname,
    super.avatar,
    super.phone,
    super.org,
    super.currentWorkplace,
    super.user,
    super.job,
    super.specCat,
    super.specialistOrders,
    super.isWorking,
    super.isCatHead,
    super.operatingMode,
    super.position,
    super.autoMode,
    super.accepted,
    super.todayTimetable,
    super.experience,
    super.bio,
    super.location,
    super.orderCount,
  });

  factory SpecialistsModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialistsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialistsModelToJson(this);
}
