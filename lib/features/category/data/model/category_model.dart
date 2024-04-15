import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/category/domain/entity/catigory_entity.dart';

part 'category_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CategoryModel extends CategoryEntity {
  const CategoryModel({
    super.id,
    super.name,
    super.productNumbers,
    super.productExist,
    super.isActive,
    super.image,
    super.createDate,
    super.org,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
