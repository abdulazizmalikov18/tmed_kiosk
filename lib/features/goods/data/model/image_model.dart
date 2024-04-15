import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/image_entity.dart';

part 'image_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ImageModel extends ImageEntity {
  const ImageModel({
    super.id,
    super.file,
    super.main,
    super.org,
    super.product,
    super.status,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
