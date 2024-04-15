import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/data/model/group_model.dart';

class GroupEntity extends Equatable {
  final int group;

  const GroupEntity({
    this.group = 0,
  });

  @override
  List<Object?> get props => [
        group,
      ];
}

class GroupConverter
    implements JsonConverter<GroupEntity, Map<String, dynamic>?> {
  const GroupConverter();
  @override
  GroupEntity fromJson(Map<String, dynamic>? json) =>
      GroupModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(GroupEntity object) => {};
}
