import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/domain/entity/data_entity.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends Equatable {
  const UserModel({
    this.username = '',
    this.name = '',
    this.surname = '',
    this.lastname = '',
    this.email = '',
    this.phone = '',
    this.birthday = '',
    this.gender = '',
    this.bio = '',
    this.status = 0,
    this.isRelated = false,
    this.region = const DataEntity(),
    this.mainCat = const DataEntity(),
    this.avatar = '',
    this.qrcode = '',
    this.hasPassword = false,
  });

  final String username;
  final String name;
  final String surname;
  final String lastname;
  final dynamic email;
  final String phone;
  final String birthday;
  final String gender;
  final dynamic bio;
  final int status;
  final bool isRelated;
  @DataEntityConverter()
  final DataEntity region;
  @DataEntityConverter()
  final DataEntity mainCat;
  final String avatar;
  final String qrcode;
  final bool hasPassword;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  @override
  List<Object?> get props => [
        username,
        name,
        surname,
        lastname,
        email,
        phone,
        birthday,
        gender,
        bio,
        status,
        isRelated,
        region,
        mainCat,
        avatar,
        qrcode,
        hasPassword,
      ];
}
