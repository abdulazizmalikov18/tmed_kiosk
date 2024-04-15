import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/main_cat_entity.dart';

part 'main_cat_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MainCatModel extends MainCatEntity {
  const MainCatModel({
    super.id,
    super.name,
    super.description,
    super.image,
    super.parent,
    super.userCount,
  });

  factory MainCatModel.fromJson(Map<String, dynamic> json) =>
      _$MainCatModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainCatModelToJson(this);
}
