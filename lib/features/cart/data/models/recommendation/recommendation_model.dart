import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/recommendation/rec_product_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/recommendation/rec_specialist_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/recommendation/recommendation_entity.dart';

part 'recommendation_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RecommendationModel extends RecommendationEntity {
  const RecommendationModel({
    super.id,
    super.specialist,
    super.products,
    super.createDate,
    super.status,
    super.user,
    super.fromUser,
    super.orderProduct,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationModelToJson(this);
}
