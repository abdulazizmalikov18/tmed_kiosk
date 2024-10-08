import 'package:tmed_kiosk/features/cart/domain/entity/a_region_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/main_cat_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/data/models/user_account_model.dart';

class UserAccountEntity extends Equatable {
  final String username;
  final String name;
  final String lastname;
  final String surname;
  final String phone;
  final String gender;
  final String birthday;
  @MainCatConverter()
  final MainCatEntity mainCat;
  @ARegionConverter()
  final ARegionEntity region;
  final String qrcode;
  final String pinfl;

  const UserAccountEntity({
    this.username = "",
    this.name = "",
    this.lastname = "",
    this.surname = "",
    this.phone = "",
    this.gender = "",
    this.birthday = "",
    this.mainCat = const MainCatEntity(),
    this.region = const ARegionEntity(),
    this.qrcode = "",
    this.pinfl = "",
  });

  @override
  List<Object?> get props => [
        username,
        name,
        lastname,
        surname,
        phone,
        gender,
        birthday,
        mainCat,
        region,
        qrcode,
        pinfl,
      ];
}

class UserAccountConverter
    implements JsonConverter<UserAccountEntity, Map<String, dynamic>?> {
  const UserAccountConverter();
  @override
  UserAccountEntity fromJson(Map<String, dynamic>? json) =>
      UserAccountModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(UserAccountEntity object) => {};
}
