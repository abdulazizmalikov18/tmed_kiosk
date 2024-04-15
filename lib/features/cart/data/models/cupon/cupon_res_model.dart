import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/cupon_res_entity.dart';

part 'cupon_res_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CuponResModel extends CuponResEntity {
  const CuponResModel({
    super.id,
    super.user,
    super.date,
  });

  factory CuponResModel.fromJson(Map<String, dynamic> json) =>
      _$CuponResModelFromJson(json);

  Map<String, dynamic> toJson() => _$CuponResModelToJson(this);
}
