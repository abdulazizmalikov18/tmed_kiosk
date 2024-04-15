part of 'package:tmed_kiosk/features/cart/presentation/views/cart_phone_view.dart';

mixin CartPhoneMixin on State<CartPhoneView> {
  late final vm = CartViewModel();
  bool isPrice = false;
  @override
  void initState() {
    isPrice = context.read<PriceBloc>().state.isPrice;
    super.initState();
  }

  void createOrder({
    required Map<int, OrgProductEntity> cartMap,
    required String selUsername,
    required String username,
    required List<ListCount> counts,
    required String isOrder,
  }) {
    context.read<CartBloc>().add(
          CreatOrder(
            username: selUsername.isNotEmpty ? selUsername : null,
            filter: PostProductFilter(clientComment: vm.controllerComment.text),
            onError: (nima) {
              context
                  .read<ShowPopUpBloc>()
                  .add(ShowPopUp(message: nima, status: PopStatus.error));
            },
            onSuccess: (data) {
              context.read<MyNavigatorBloc>().add(OpenCart(false));
              context.read<ShowPopUpBloc>().add(ShowPopUp(
                    message: MyFunctions.createPrice(context),
                    status: PopStatus.success,
                  ));
              context.read<GoodsBloc>().add(GetOrgProduct());
              widget.vm.clearAccount(context);
              vm.controllerComment.clear();
            },
          ),
        );
  }

  createOrders(AccountsState stateAccount) {
    context.read<CartBloc>().add(
          CreatOrder(
            username:
                stateAccount.selectAccount.selectAccount.username.isNotEmpty
                    ? stateAccount.selectAccount.selectAccount.username
                    : null,
            onSuccess: (data) {
              Navigator.pop(context);
              context.read<ShowPopUpBloc>().add(ShowPopUp(
                    message: MyFunctions.createPrice(context),
                    status: PopStatus.success,
                  ));
              context.read<GoodsBloc>().add(GetOrgProduct());
              widget.vm.clearAccount(context);
              vm.controllerComment.clear();
            },
            onError: (nima) {
              context
                  .read<ShowPopUpBloc>()
                  .add(ShowPopUp(message: nima, status: PopStatus.error));
            },
          ),
        );
  }
}
