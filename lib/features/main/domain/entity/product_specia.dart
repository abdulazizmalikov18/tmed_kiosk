import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/main/data/model/product_special.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/specialist_entity.dart';

class ProductSpecialEntity extends Equatable {
  final int id;
  @SpecialistsConverter()
  final SpecialistsEntity specialist;
  final int product;

  const ProductSpecialEntity({
    this.id = 0,
    this.specialist = const SpecialistsEntity(),
    this.product = 0,
  });

  @override
  List<Object?> get props => [
        id,
        specialist,
        product,
      ];
}

class ProductSpecialConverter
    implements JsonConverter<ProductSpecialEntity, Map<String, dynamic>?> {
  const ProductSpecialConverter();
  @override
  ProductSpecialEntity fromJson(Map<String, dynamic>? json) =>
      ProductSpecialModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(ProductSpecialEntity object) => {};
}
