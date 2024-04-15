import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/category/data/model/category_model.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final int productNumbers;
  final bool productExist;
  final String org;
  final String image;
  final bool isActive;
  final String createDate;

  const CategoryEntity({
    this.id = 0,
    this.name = '',
    this.image = '',
    this.productNumbers = 0,
    this.productExist = false,
    this.org = '',
    this.isActive = false,
    this.createDate = '',
  });
  @override
  List<Object?> get props => [
        id,
        name,
        productNumbers,
        productExist,
        org,
        image,
        isActive,
        createDate,
      ];
}

class CategoryEntityConverter
    implements JsonConverter<CategoryEntity, Map<String, dynamic>?> {
  const CategoryEntityConverter();

  @override
  CategoryEntity fromJson(Map<String, dynamic>? json) =>
      CategoryModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(CategoryEntity object) => {};
}
