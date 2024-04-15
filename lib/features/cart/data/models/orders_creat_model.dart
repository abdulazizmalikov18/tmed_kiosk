class OrdersCreatModel {
  String? action;
  List<Map<String, Object?>>? cartProducts;
  int? paymentCard;
  List<Map<String, dynamic>>? payments;
  String? specsComment;
  String? clientComment;
  int? couponId;
  int? processStatus;
  String? clientUsername;
  // String? meetAddress;

  OrdersCreatModel({
    this.action = '',
    this.payments,
    this.processStatus,
    this.cartProducts,
    this.specsComment = '',
    this.clientComment = '',
    this.couponId,
    this.paymentCard,
    this.clientUsername,
  });

  OrdersCreatModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    payments = json['payments'];
    cartProducts = json['cart_products'];
    specsComment = json['specs_comment'];
    clientComment = json['client_comment'];
    couponId = json['coupon_id'];
    processStatus = json['process_status'];
    paymentCard = json['payment_card'];
    clientUsername = json['client_username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['action'] = action;
    data['payments'] = payments;
    data['cart_products'] = cartProducts;
    data['specs_comment'] = specsComment;
    data['client_comment'] = clientComment;
    data['coupon_id'] = couponId;
    data['process_status'] = processStatus;
    data['payment_card'] = paymentCard;
    data['client_username'] = clientUsername;
    return data;
  }
}
