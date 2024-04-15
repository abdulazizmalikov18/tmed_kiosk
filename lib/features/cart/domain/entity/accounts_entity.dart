import 'package:equatable/equatable.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/a_region_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/main_cat_entity.dart';

class AccountsEntity extends Equatable {
  final int id;
  final String username;
  final String name;
  final int status;
  final String lastname;
  final String phone;
  final String birthday;
  final String gender;
  final List<String> avatar;
  @MainCatConverter()
  final MainCatEntity mainCat;
  final String pinfl;
  @ARegionConverter()
  final ARegionEntity region;
  final List<dynamic> parents;

  const AccountsEntity({
    this.id = 0,
    this.username = '',
    this.status = 0,
    this.name = '',
    this.lastname = '',
    this.phone = '',
    this.avatar = const [],
    this.mainCat = const MainCatEntity(),
    this.region = const ARegionEntity(),
    this.pinfl = '',
    this.birthday = '',
    this.gender = '',
    this.parents = const [],
  });

  @override
  List<Object?> get props => [
        id,
        username,
        status,
        name,
        lastname,
        phone,
        avatar,
        mainCat,
        region,
        pinfl,
        birthday,
        gender,
        parents,
      ];
}
