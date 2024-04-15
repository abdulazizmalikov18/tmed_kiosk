import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/models/order_user_model.dart';

class OrderUserEntity extends Equatable {
  final String username;
  final String name;
  final String lastname;
  final String avatar;
  final String birthdate;
  final dynamic region;
  final String gender;
  final dynamic mainCat;

  const OrderUserEntity({
    this.username = '',
    this.name = '',
    this.lastname = '',
    this.avatar = '',
    this.birthdate = '',
    this.region,
    this.gender = '',
    this.mainCat,
  });

  @override
  List<Object?> get props => [
        username,
        name,
        lastname,
        avatar,
        birthdate,
        region,
        gender,
        mainCat,
      ];
}

class OrderUserConverter
    implements JsonConverter<OrderUserEntity, Map<String, dynamic>?> {
  const OrderUserConverter();

  @override
  OrderUserEntity fromJson(Map<String, dynamic>? json) =>
      OrderUserModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(OrderUserEntity object) => {};
}
