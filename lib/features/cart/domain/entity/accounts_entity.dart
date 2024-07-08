import 'package:equatable/equatable.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/a_region_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/main_cat_entity.dart';

class AccountsEntity extends Equatable {
  final int id;
  final String username;
  final String name;
  final int status;
  final String lastname;
  final String surname;
  final String education;
  final String phone;
  final String birthPlace;
  final String nationality;
  final String currentPlace;
  final String birthday;
  final String gender;
  final List<String> avatar;
  @MainCatConverter()
  final MainCatEntity mainCat;
  final String pinfl;
  @ARegionConverter()
  final ARegionEntity region;
  final List<dynamic> parents;
  final bool isAfgan;
  final bool isCherno;
  final bool isInvalid;
  final bool isUvu;
  final String position;
  final String type;

  const AccountsEntity({
    this.id = 0,
    this.username = '',
    this.status = 0,
    this.name = '',
    this.birthPlace = '',
    this.currentPlace = '',
    this.nationality = '',
    this.lastname = '',
    this.surname = '',
    this.phone = '',
    this.education = '',
    this.avatar = const [],
    this.isAfgan = false,
    this.isCherno = false,
    this.isInvalid = false,
    this.isUvu = false,
    this.position = "",
    this.mainCat = const MainCatEntity(),
    this.region = const ARegionEntity(),
    this.pinfl = '',
    this.birthday = '',
    this.gender = '',
    this.parents = const [],
    this.type = "",
  });

  @override
  List<Object?> get props => [
        id,
        username,
        status,
        birthPlace,
        currentPlace,
        nationality,
        surname,
        education,
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
        isAfgan,
        isCherno,
        isInvalid,
        isUvu,
        position,
        type,
      ];
}
