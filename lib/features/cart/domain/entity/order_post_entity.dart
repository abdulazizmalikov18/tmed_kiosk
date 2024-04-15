import 'package:equatable/equatable.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/pay_order_set_entity.dart';

class OrderPostEntity extends Equatable {
  final int cart;
  final int card;
  final int payment;
  final String specsComment;
  final String clientComment;
  final int coupon;
  final String action;
  @PayOrderSetConverter()
  final List<PaymentinorderSet> paymentinorderSet;
  final int processStatus;

  const OrderPostEntity({
    this.action = '',
    this.cart = 0,
    this.paymentinorderSet = const [],
    this.processStatus = 0,
    this.card = 0,
    this.payment = 0,
    this.specsComment = '',
    this.clientComment = '',
    this.coupon = 0,
  });

  @override
  List<Object?> get props => [
        action,
        cart,
        paymentinorderSet,
        processStatus,
        card,
        payment,
        specsComment,
        clientComment,
        coupon,
      ];
}
