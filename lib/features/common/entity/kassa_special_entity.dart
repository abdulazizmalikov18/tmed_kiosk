import 'package:equatable/equatable.dart';
import 'package:tmed_kiosk/features/common/entity/kassa_job_entity.dart';
import 'package:tmed_kiosk/features/common/entity/kassa_org_entity.dart';

class KassaSpecialEntity extends Equatable {
  final String id;
  @KassaOrgConverter()
  final KassaOrgEntity org;
  @KassaJobConverter()
  final KassaJobEntity specCat;
  final String name;
  final String lastname;
  final String avatar;
  @KassaJobConverter()
  final KassaJobEntity job;

  final bool auto;
  final String locationDesc;

  const KassaSpecialEntity({
    this.id = '',
    this.org = const KassaOrgEntity(),
    this.specCat = const KassaJobEntity(),
    this.name = '',
    this.lastname = '',
    this.avatar = '',
    this.job = const KassaJobEntity(),
    this.auto = false,
    this.locationDesc = '',
  });

  @override
  List<Object?> get props => [
        id,
        org,
        specCat,
        name,
        lastname,
        avatar,
        job,
        auto,
        locationDesc,
      ];
}
