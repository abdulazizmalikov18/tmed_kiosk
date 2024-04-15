import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/data/model/image_model.dart';

class ImageEntity extends Equatable {
  final int id;
  final String file;
  final bool main;
  final bool status;
  final dynamic org;
  final int product;

  const ImageEntity({
    this.id = 0,
    this.file = '',
    this.main = false,
    this.status = false,
    this.org = '',
    this.product = 0,
  });

  @override
  List<Object?> get props => [
        id,
        file,
        main,
        status,
        org,
        product,
      ];
}

class ImageConverter
    implements JsonConverter<ImageEntity, Map<String, dynamic>?> {
  const ImageConverter();
  @override
  ImageEntity fromJson(Map<String, dynamic>? json) =>
      ImageModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(ImageEntity object) => {};
}
