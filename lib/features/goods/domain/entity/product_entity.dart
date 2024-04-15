import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/data/model/product_model.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/image_entity.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/spec_cat_entity.dart';

class ProductEntity extends Equatable {
  final String code;
  final String name;
  @SpecCatConverter()
  final SpecCatEntity manufacturer;
  @SpecCatConverter()
  final SpecCatEntity type;
  @SpecCatConverter()
  final SpecCatEntity unit;
  @ImageConverter()
  final ImageEntity image;
  @ImageConverter()
  final List<ImageEntity> images;

  const ProductEntity({
    this.code = '',
    this.name = '',
    this.manufacturer = const SpecCatEntity(),
    this.type = const SpecCatEntity(),
    this.unit = const SpecCatEntity(),
    this.image = const ImageEntity(),
    this.images = const [],
  });

  @override
  List<Object?> get props => [
        code,
        name,
        manufacturer,
        type,
        unit,
        image,
      ];
}

class ProductConverter
    implements JsonConverter<ProductEntity, Map<String, dynamic>?> {
  const ProductConverter();
  @override
  ProductEntity fromJson(Map<String, dynamic>? json) =>
      ProductModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(ProductEntity object) => {};
}
