import 'package:tmed_kiosk/features/common/domain/entity/my_job_entity.dart';
import 'package:tmed_kiosk/features/common/domain/entity/my_location_entity.dart';
import 'package:tmed_kiosk/features/common/entity/kassa_org_entity.dart';
import 'package:equatable/equatable.dart';

class MySpecialist extends Equatable {
  final String id;
  @KassaOrgConverter()
  final KassaOrgEntity org;
  @MyJobConverter()
  final MyJobEntity specCat;
  final String name;
  final String lastname;
  @MyJobConverter()
  final MyJobEntity job;
  final bool auto;
  final String avatar;
  final String locationDesc;
  @MyLocationConverter()
  final MyLocationEntity location;

  const MySpecialist({
    this.id = "",
    this.org = const KassaOrgEntity(),
    this.specCat = const MyJobEntity(),
    this.name = "",
    this.lastname = "",
    this.job = const MyJobEntity(),
    this.auto = false,
    this.avatar = "",
    this.locationDesc = "",
    this.location = const MyLocationEntity(),
  });

  @override
  List<Object?> get props => [
        id,
        org,
        specCat,
        name,
        lastname,
        job,
        auto,
        avatar,
        locationDesc,
        location,
      ];
}
