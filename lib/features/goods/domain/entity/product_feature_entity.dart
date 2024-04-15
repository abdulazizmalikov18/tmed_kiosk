import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/data/model/product_feature_model.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/feature_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/prepared_value_entity.dart';

class ProductFeatureEntity extends Equatable {
  final int id;
  @FeatureConverter()
  final FeatureEntity feature;
  final dynamic value;
  @PreparedValueConverter()
  final List<PreparedValueEntity> preparedValue;

  const ProductFeatureEntity({
    this.id = 0,
    this.feature = const FeatureEntity(),
    this.value,
    this.preparedValue = const [],
  });

  @override
  List<Object?> get props => [
        id,
        feature,
        value,
        preparedValue,
      ];
}

class ProductFeatureConverter
    implements JsonConverter<ProductFeatureEntity, Map<String, dynamic>?> {
  const ProductFeatureConverter();
  @override
  ProductFeatureEntity fromJson(Map<String, dynamic>? json) =>
      ProductFeatureModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(ProductFeatureEntity object) => {};
}
