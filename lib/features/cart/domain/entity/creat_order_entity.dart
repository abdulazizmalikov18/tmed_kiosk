import 'package:equatable/equatable.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/pay_order_set_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/product_cart_entity.dart';

class CreateOrderEntity extends Equatable {
  final String action;
  @CartProductConverter()
  final List<CartProductEntity> cartProducts;
  final int paymentCard;
  @PayOrderSetConverter()
  final List<PaymentinorderSet> payments;
  // final String specsComment;
  final String clientComment;
  // final MeetAddress meetAddress;
  final int couponId;
  final int processStatus;
  final String clientUsername;

  const CreateOrderEntity({
    this.action = "",
    this.cartProducts = const [],
    this.paymentCard = 0,
    this.payments = const [],
    // this.specsComment = "",
    this.clientComment = "",
    // this.meetAddress = "",
    this.couponId = 0,
    this.processStatus = 0,
    this.clientUsername = "",
  });

  @override
  List<Object?> get props => [
        action,
        cartProducts,
        paymentCard,
        payments,
        // specsComment,
        clientComment,
        // meetAddress,
        couponId,
        processStatus,
        clientUsername,
      ];
}
