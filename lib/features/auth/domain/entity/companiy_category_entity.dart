import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/auth/data/model/companiy_category_model.dart';

class CompaniyCategoryEntity extends Equatable {
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

  const CompaniyCategoryEntity({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.hideFromOrgs = false,
    this.hideFromUsers = false,
    this.image = '',
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

class CompaniyCategoryConverter
    implements JsonConverter<CompaniyCategoryEntity, Map<String, dynamic>?> {
  const CompaniyCategoryConverter();
  @override
  CompaniyCategoryEntity fromJson(Map<String, dynamic>? json) =>
      CompaniyCategoryModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(CompaniyCategoryEntity object) => {};
}
