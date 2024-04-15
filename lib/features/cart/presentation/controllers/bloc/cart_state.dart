part of 'cart_bloc.dart';

class CartState extends Equatable {
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus aStatus;
  final List<ListCount> counts;
  final List<ProcessStatusEntity> processStatus;
  final Map<int, OrgProductEntity> cartMap;
  final OrgCartEntity orgCart;
  final List<CartProductEntity> postcart;

  final int allPrice;
  final int discount;
  final int avans;
  final CuponEntity cupon;
  final ProcessStatusEntity selStatus;
  final String isOrder;
  final String username;

  const CartState({
    this.status = FormzSubmissionStatus.initial,
    this.aStatus = FormzSubmissionStatus.initial,
    this.counts = const [],
    this.processStatus = const [],
    this.cartMap = const {},
    this.orgCart = const OrgCartEntity(),
    this.postcart = const [],
    this.allPrice = 0,
    this.discount = 0,
    this.avans = 0,
    this.cupon = const CuponEntity(),
    this.selStatus = const ProcessStatusEntity(),
    this.isOrder = "",
    this.username = "",
  });

  CartState copyWith({
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? aStatus,
    Map<int, OrgProductEntity>? cartMap,
    List<ListCount>? counts,
    OrgCartEntity? orgCart,
    List<CartProductEntity>? postcart,
    List<ProcessStatusEntity>? processStatus,
    int? allPrice,
    int? discount,
    int? avans,
    CuponEntity? cupon,
    ProcessStatusEntity? selStatus,
    String? isOrder,
    String? username,
  }) =>
      CartState(
        status: status ?? this.status,
        aStatus: aStatus ?? this.aStatus,
        counts: counts ?? this.counts,
        cartMap: cartMap ?? this.cartMap,
        orgCart: orgCart ?? this.orgCart,
        postcart: postcart ?? this.postcart,
        processStatus: processStatus ?? this.processStatus,
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
        aStatus,
        processStatus,
        isOrder,
        allPrice,
        discount,
        cupon,
        selStatus,
        username,
      ];
}
