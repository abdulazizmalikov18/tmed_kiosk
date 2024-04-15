part of 'cart_bloc.dart';

abstract class CartEvent {}

class CreatOrder extends CartEvent {
  final Function(OrdersEntity) onSuccess;
  final Function(String) onError;
  final PostProductFilter filter;
  final String? username;
  CreatOrder({
    required this.onSuccess,
    required this.onError,
    this.filter = const PostProductFilter(),
    this.username,
  });
}

class CuponSel extends CartEvent {
  final CuponEntity cupon;

  CuponSel({required this.cupon});
}

class UpdateOrder extends CartEvent {
  final UpdateOrdersModel model;
  final VoidCallback onSuccess;
  final Function(String) onError;

  UpdateOrder({
    required this.model,
    required this.onSuccess,
    required this.onError,
  });
}

class RemoveCupon extends CartEvent {}

class CartAddMap extends CartEvent {
  final OrgProductEntity product;
  final int index;
  final ProductSpecialEntity? psp;
  final DateTime? dateTime;
  final int? discountPrice;
  final List<int>? surchargeIds;
  final int? supplies;
  final int? selectIndex;
  final int? dataIndex;
  final bool isCart;
  final int pricePercent;
  final int? count;

  CartAddMap(
    this.product,
    this.index, {
    this.psp,
    this.pricePercent = 0,
    this.dateTime,
    this.discountPrice,
    this.supplies,
    this.surchargeIds,
    this.selectIndex,
    this.dataIndex,
    this.isCart = false,
    this.count,
  });
}

class CartEdit extends CartEvent {
  final OrgProductEntity orgProductCart;
  final int index;
  final ProductSpecialEntity? psp;
  final DateTime? dateTime;
  final int? discountPrice;
  final List<int>? surchargeIds;
  final int? supplies;
  final int? selectIndex;
  final int? dataIndex;
  final int pricePercent;

  CartEdit(
    this.orgProductCart,
    this.index, {
    required this.pricePercent,
    this.psp,
    this.dateTime,
    this.discountPrice,
    this.supplies,
    this.surchargeIds,
    this.selectIndex,
    this.dataIndex,
  });
}

class CartRemove extends CartEvent {
  final bool isOrder;

  CartRemove({this.isOrder = false});
}

class CountEdit extends CartEvent {
  final List<ListCount> counts;
  final int allPrice;
  final int discount;
  CountEdit(this.counts, this.allPrice, this.discount);
}

class PayCloseOrder extends CartEvent {
  final OrdersEntity orders;

  PayCloseOrder({required this.orders});
}

class SelStatus extends CartEvent {
  final ProcessStatusEntity selStatus;

  SelStatus({required this.selStatus});
}

class GetProcessStatus extends CartEvent {}

class CartAddOrder extends CartEvent {
  final OrdersEntity orders;
  final VoidCallback onSuccess;
  final Function(String) onError;

  CartAddOrder({
    required this.orders,
    required this.onSuccess,
    required this.onError,
  });
}

class CartAddRecommendation extends CartEvent {
  final List<RecProductEntity> products;
  final VoidCallback onSuccess;
  final Function(String) onError;

  CartAddRecommendation({
    required this.products,
    required this.onSuccess,
    required this.onError,
  });
}
