import 'package:equatable/equatable.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/recommendation/rec_product_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/recommendation/rec_specialist_entity.dart';

class RecommendationEntity extends Equatable {
  final int id;
  @RecSpecialistConverter()
  final RecSpecialistEntity specialist;
  @RecProductConverter()
  final List<RecProductEntity> products;
  final String createDate;
  final int status;
  final String user;
  final dynamic fromUser;
  final dynamic orderProduct;
  const RecommendationEntity({
    this.id = 0,
    this.specialist = const RecSpecialistEntity(),
    this.products = const [],
    this.createDate = "",
    this.status = 0,
    this.user = "",
    this.fromUser = 0,
    this.orderProduct = 0,
  });

  @override
  List<Object?> get props => [
        id,
        specialist,
        products,
        createDate,
        status,
        user,
        fromUser,
        orderProduct,
      ];
}
