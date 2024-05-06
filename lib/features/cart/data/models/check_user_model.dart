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
  @JsonKey(name: "photo")
  final String photo;
  @JsonKey(name: "education")
  final String education;
  @JsonKey(name: "nationality")
  final String nationality;
  @JsonKey(name: "phone")
  final String phone;
  @JsonKey(name: "birth_place")
  final String birthPlace;
  @JsonKey(name: "current_place")
  final String currentPlace;
  @JsonKey(name: "positions")
  final List<dynamic> positions;
  @JsonKey(name: "last_med")
  final dynamic lastMed;

  const Exodim({
    this.id = 0,
    this.name = "",
    this.photo = "",
    this.education = "",
    this.nationality = "",
    this.phone = "",
    this.birthPlace = "",
    this.currentPlace = "",
    this.positions = const [],
    this.lastMed,
  });

  factory Exodim.fromJson(Map<String, dynamic> json) => _$ExodimFromJson(json);

  Map<String, dynamic> toJson() => _$ExodimToJson(this);
}
