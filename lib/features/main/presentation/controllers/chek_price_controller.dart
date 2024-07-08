part of 'package:tmed_kiosk/features/main/presentation/widgets/chek_price_iteam.dart';

mixin CheckPriceController on State<ChekPriceIteam> {
  bool isDeisebled(int id) {
    if (widget.tabIndex.index == 0 &&
        widget.allPrice > widget.moneyEntered + widget.avans) {
      return true;
    } else if (widget.tabIndex.index == 1 && widget.isOrder.isNotEmpty) {
      return false;
    } else if (widget.tabIndex.index == 1 && id == 1 || id == 2) {
      return true;
    } else {
      return false;
    }
  }

  checkStatus(CartState state) {
    if (widget.tabIndex.index == 0 &&
        widget.allPrice > widget.moneyEntered + widget.avans) {
      context.read<ShowPopUpBloc>().add(ShowPopUp(
            message: "To'liq summani kirgazing",
            status: PopStatus.warning,
          ));
    } else {
      List<Map<String, dynamic>> nimadir = [];
      for (var i = 1; i < widget.list.length; i++) {
        if (widget.list[i].controller.text.isNotEmpty) {
          nimadir.add({
            "method": widget.list[i].method,
            "cost": widget.list[i].controller.text.replaceAll(" ", "")
          });
        }
      }
      creatOrder(param: nimadir, state: state);
    }
  }

  creatOrder({
    required List<Map<String, dynamic>> param,
    required CartState state,
  }) {
    Log.w("Create Order");
    final stateAccount = context.read<AccountsBloc>().state;
    context.read<CartBloc>().add(CreatOrder(
          username: state.username.isEmpty
              ? stateAccount.selectAccount.selectAccount.username.isEmpty
                  ? null
                  : stateAccount.selectAccount.selectAccount.username
              : state.username,
          onError: (nima) {
            context
                .read<ShowPopUpBloc>()
                .add(ShowPopUp(message: nima, status: PopStatus.error));
          },
          onSuccess: (data) async {
            context.read<GoodsBloc>().add(GetOrgProduct(isLoading: false));
            context.read<MyNavigatorBloc>().add(NavId(0));
            context.read<MyNavigatorBloc>().add(OpenCart(false));
            context.read<ShowPopUpBloc>().add(ShowPopUp(
                  message: MyFunctions.createPrice(context),
                  status: PopStatus.success,
                ));
            widget.vmA.clearAccount(context);
            final tashkilot = context
                .read<AuthenticationBloc>()
                .state
                .listSpecial
                .where((element) =>
                    element.id == StorageRepository.getString(StorageKeys.SPID))
                .first
                .org
                .name;
            final dataPrint = widget.tabIndex.index != 0
                ? await ReceiptRoll80Avans(
                        data: data, vat: widget.vat, tashkilot: tashkilot)
                    .show()
                : await ReceiptRoll80(
                        data: data, vat: widget.vat, tashkilot: tashkilot)
                    .show();

            return showDialog(
              context: context,
              builder: (context) => PrinterDialog(data: dataPrint),
            );
          },
          filter: PostProductFilter(
            method: widget.tabIndex.index == 0,
            paymentinorderSet: param,
            processStatus: widget.tabIndex.index == 0 ? state.selStatus.id : 1,
            clientComment: widget.list.first.controller.text,
          ),
          isCupon: widget.vm.isCupon,
        ));
  }
}
