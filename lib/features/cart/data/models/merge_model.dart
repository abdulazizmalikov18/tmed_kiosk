import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'merge_model.g.dart';

MergeModel mergeModelFromJson(String str) =>
    MergeModel.fromJson(json.decode(str));

String mergeModelToJson(MergeModel data) => json.encode(data.toJson());

@JsonSerializable()
class MergeModel {
  @JsonKey(name: "main_user")
  final int mainUser;
  @JsonKey(name: "users")
  final List<int> users;

  MergeModel({
    required this.mainUser,
    required this.users,
  });

  factory MergeModel.fromJson(Map<String, dynamic> json) =>
      _$MergeModelFromJson(json);

  Map<String, dynamic> toJson() => _$MergeModelToJson(this);
}
