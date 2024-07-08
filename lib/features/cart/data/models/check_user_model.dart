// To parse this JSON data, do
//
//     final checkUserModel = checkUserModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'check_user_model.g.dart';

CheckUserModel checkUserModelFromJson(String str) =>
    CheckUserModel.fromJson(json.decode(str));

String checkUserModelToJson(CheckUserModel data) => json.encode(data.toJson());

@JsonSerializable()
class CheckUserModel {
  @JsonKey(name: "status")
  final bool status;
  @JsonKey(name: "exodim")
  final Map<String, dynamic> exodim;
  @JsonKey(name: "status_e_xodim")
  final bool statusEXodim;

  const CheckUserModel({
    this.status = false,
    this.exodim = const {},
    this.statusEXodim = false,
  });

  factory CheckUserModel.fromJson(Map<String, dynamic> json) =>
      _$CheckUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUserModelToJson(this);
}

@JsonSerializable()
class Exodim {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "last_name")
  final String lastName;
  @JsonKey(name: "first_name")
  final String firstName;
  @JsonKey(name: "middle_name")
  final String middleName;
  @JsonKey(name: "photo")
  final String photo;
  @JsonKey(name: "birthday")
  final String birthday;
  @JsonKey(name: "sex")
  final String sex;
  @JsonKey(name: "education")
  final String education;
  @JsonKey(name: "nationality")
  final String nationality;
  @JsonKey(name: "phone")
  final String phone;
  @JsonKey(name: "relatives")
  final List<Relative> relatives;
  @JsonKey(name: "birth_place")
  final String birthPlace;
  @JsonKey(name: "current_place")
  final String currentPlace;
  @JsonKey(name: "positions")
  final List<Position> positions;
  @JsonKey(name: "last_med")
  final dynamic lastMed;
  @JsonKey(name: "comment")
  final Comment comment;

  const Exodim({
    this.id = 0,
    this.name = "",
    this.lastName = "",
    this.firstName = "",
    this.middleName = "",
    this.photo = "",
    this.birthday = "",
    this.sex = "",
    this.education = "",
    this.nationality = "",
    this.phone = "",
    this.relatives = const [],
    this.birthPlace = "",
    this.currentPlace = "",
    this.positions = const [],
    this.lastMed = "",
    this.comment = const Comment(),
  });

  factory Exodim.fromJson(Map<String, dynamic> json) => _$ExodimFromJson(json);

  Map<String, dynamic> toJson() => _$ExodimToJson(this);
}

@JsonSerializable()
class Comment {
  @JsonKey(name: "afghan")
  final String afghan;
  @JsonKey(name: "invalid")
  final String invalid;
  @JsonKey(name: "chernobyl")
  final String chernobyl;
  @JsonKey(name: "railway_title")
  final String railwayTitle;

  const Comment({
    this.afghan = "",
    this.invalid = "",
    this.chernobyl = "",
    this.railwayTitle = "",
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
class Position {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "organization")
  final Organization organization;
  @JsonKey(name: "position")
  final String position;
  @JsonKey(name: "position_type")
  final String positionType;
  @JsonKey(name: "position_extension")
  final dynamic positionExtension;

  const Position({
    required this.id,
    required this.organization,
    required this.position,
    required this.positionType,
    required this.positionExtension,
  });

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);
}

@JsonSerializable()
class Organization {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "inn")
  final int inn;

  const Organization({
    required this.id,
    required this.name,
    required this.inn,
  });

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}

@JsonSerializable()
class Relative {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "relative")
  final String relative;
  @JsonKey(name: "full_name")
  final String fullName;
  @JsonKey(name: "birth_place")
  final String birthPlace;
  @JsonKey(name: "post")
  final String post;
  @JsonKey(name: "address")
  final String address;

  const Relative({
    required this.id,
    required this.relative,
    required this.fullName,
    required this.birthPlace,
    required this.post,
    required this.address,
  });

  factory Relative.fromJson(Map<String, dynamic> json) =>
      _$RelativeFromJson(json);

  Map<String, dynamic> toJson() => _$RelativeToJson(this);
}
