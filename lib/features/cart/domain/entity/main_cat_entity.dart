import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/data/models/main_cat_model.dart';

class MainCatEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String image;
  final int parent;
  final int userCount;

  const MainCatEntity({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.image = '',
    this.parent = 0,
    this.userCount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        parent,
        userCount,
      ];
}

class MainCatConverter
    implements JsonConverter<MainCatEntity, Map<String, dynamic>?> {
  const MainCatConverter();
  @override
  MainCatEntity fromJson(Map<String, dynamic>? json) =>
      MainCatModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(MainCatEntity object) => {};
}
