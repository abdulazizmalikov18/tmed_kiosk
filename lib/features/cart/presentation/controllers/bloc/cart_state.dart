part of 'cart_bloc.dart';

class CartState extends Equatable {
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus aStatus;
  final List<ListCount> counts;
  final List<ProcessStatusEntity> processStatus;
  final List<ProcessStatusEntity> processStatusAll;
  final Map<int, OrgProductEntity> cartMap;
  final Map<int, OrderProductEntity> cartMapDel;
  final OrgCartEntity orgCart;
  final List<CartProductEntity> postcart;
  final OrdersEntity orders;
  final int allPrice;
  final int discount;
  final int avans;
  final CuponModel cupon;
  final ProcessStatusEntity selStatus;
  final String isOrder;
  final String username;
  final List<int> statusID;

  const CartState({
    this.status = FormzSubmissionStatus.initial,
    this.aStatus = FormzSubmissionStatus.initial,
    this.counts = const [],
    this.statusID = const [],
    this.processStatus = const [],
    this.processStatusAll = const [],
    this.cartMap = const {},
    this.cartMapDel = const {},
    this.orgCart = const OrgCartEntity(),
    this.postcart = const [],
    this.orders = const OrdersEntity(),
    this.allPrice = 0,
    this.discount = 0,
    this.avans = 0,
    this.cupon = const CuponModel(),
    this.selStatus = const ProcessStatusEntity(),
    this.isOrder = "",
    this.username = "",
  });

  CartState copyWith({
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? aStatus,
    Map<int, OrgProductEntity>? cartMap,
    Map<int, OrderProductEntity>? cartMapDel,
    List<ListCount>? counts,
    List<int>? statusID,
    OrgCartEntity? orgCart,
    List<CartProductEntity>? postcart,
    OrdersEntity? orders,
    List<ProcessStatusEntity>? processStatus,
    List<ProcessStatusEntity>? processStatusAll,
    int? allPrice,
    int? discount,
    int? avans,
    CuponModel? cupon,
    ProcessStatusEntity? selStatus,
    String? isOrder,
    String? username,
  }) =>
      CartState(
        status: status ?? this.status,
        statusID: statusID ?? this.statusID,
        aStatus: aStatus ?? this.aStatus,
        counts: counts ?? this.counts,
        cartMap: cartMap ?? this.cartMap,
        cartMapDel: cartMapDel ?? this.cartMapDel,
        orgCart: orgCart ?? this.orgCart,
        postcart: postcart ?? this.postcart,
        orders: orders ?? this.orders,
        processStatus: processStatus ?? this.processStatus,
        processStatusAll: processStatusAll ?? this.processStatusAll,
        isOrder: isOrder ?? this.isOrder,
        allPrice: allPrice ?? this.allPrice,
        discount: discount ?? this.discount,
        cupon: cupon ?? this.cupon,
        avans: avans ?? this.avans,
        selStatus: selStatus ?? this.selStatus,
        username: username ?? this.username,
      );

  @override
  List<Object> get props => [
        cartMap,
        counts,
        orgCart,
        avans,
        status,
        postcart,
        orders,
        cartMapDel,
        aStatus,
        processStatus,
        processStatusAll,
        isOrder,
        allPrice,
        discount,
        cupon,
        selStatus,
        username,
        statusID,
      ];
}
