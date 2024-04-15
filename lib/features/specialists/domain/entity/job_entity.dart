import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/specialists/data/model/job_model.dart';

class JobEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final bool hideFromOrgs;
  final bool hideFromUsers;
  final String image;
  final bool status;
  final int firstLevelScore;
  final int levelProgressBy;
  final int parent;

  const JobEntity({
    this.id = 0,
    this.name = "",
    this.description = "",
    this.hideFromOrgs = false,
    this.hideFromUsers = false,
    this.image = "",
    this.status = false,
    this.firstLevelScore = 0,
    this.levelProgressBy = 0,
    this.parent = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        hideFromOrgs,
        hideFromUsers,
        image,
        status,
        firstLevelScore,
        levelProgressBy,
        parent,
      ];
}

class JobConverter implements JsonConverter<JobEntity, Map<String, dynamic>?> {
  const JobConverter();
  @override
  JobEntity fromJson(Map<String, dynamic>? json) =>
      JobModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(JobEntity object) => {};
}
