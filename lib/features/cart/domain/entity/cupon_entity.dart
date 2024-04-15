import 'package:equatable/equatable.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/extra_entity.dart';

class CuponEntity extends Equatable {
  final int id;
  @ExtraConverter()
  final ExtraEntity extra;
  final dynamic organization;
  final String title;
  final String org;
  final String user;
  final double productDiscount;
  final String backgroundColor;
  final String backgroundImage;
  final String date;

  const CuponEntity({
    this.id = 0,
    this.extra = const ExtraEntity(),
    this.organization,
    this.title = "",
    this.org = "",
    this.user = "",
    this.productDiscount = 0,
    this.backgroundColor = "",
    this.backgroundImage = "",
    this.date = "",
  });

  @override
  List<Object?> get props => [
        id,
        extra,
        organization,
        title,
        org,
        user,
        productDiscount,
        backgroundColor,
        backgroundImage,
        date,
      ];
}
