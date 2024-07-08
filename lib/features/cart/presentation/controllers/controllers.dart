part of 'package:tmed_kiosk/features/cart/presentation/views/cart_phone_view.dart';

mixin CartPhoneMixin on State<CartPhoneView> {
  late final vm = CartViewModel();
  bool isPrice = false;
  @override
  void initState() {
    isPrice = context.read<PriceBloc>().state.isPrice;
    super.initState();
  }

  Future<void> ticket(OrdersEntity data) async {
    final tashkilot = context
        .read<AuthenticationBloc>()
        .state
        .listSpecial
        .where((element) =>
            element.id == StorageRepository.getString(StorageKeys.SPID))
        .first
        .org
        .name;

    try {
      final dataPrint = await ReceiptRoll80(
        data: data,
        vat: 12,
        tashkilot: tashkilot,
      ).show();
      showDialog(
        context: context,
        builder: (context) => PrinterDialogPhone(data: dataPrint),
      );
    } catch (e) {
      // Handle any exceptions here
      Log.e(e);
    }
  }

  Future<void> ticketUpdate(OrdersEntity data, List<int> list) async {
    final tashkilot = context
        .read<AuthenticationBloc>()
        .state
        .listSpecial
        .where((element) =>
            element.id == StorageRepository.getString(StorageKeys.SPID))
        .first
        .org
        .name;
    List<pw.Widget> listTicket = [];
    for (var index = 0; index < list.length; index++) {
      var asil =
          data.products.indexWhere((element) => element.product == list[index]);
      if (asil != -1) {
        listTicket.add(ReceiptRollProduct(
          data: data,
          vat: 12,
          tashkilot: tashkilot,
          product: data.products[asil],
        ));
      }
    }

    Future<Uint8List> show() async {
      pw.Document pdf = pw.Document(version: PdfVersion.pdf_1_5);
      for (var i = 0; i < listTicket.length; i++) {
        pdf.addPage(pw.Page(
          build: (pw.Context context) => listTicket[i],
          pageFormat: PdfPageFormat.roll80,
          theme: pw.ThemeData.withFont(
            bold: pw.Font.ttf(
                await rootBundle.load("assets/fonts/NotoSans-Bold.ttf")),
            base: pw.Font.ttf(
                await rootBundle.load("assets/fonts/NotoSans-Regular.ttf")),
            italic: pw.Font.ttf(
                await rootBundle.load("assets/fonts/NotoSans-Italic.ttf")),
          ),
        ));
      }

      return await pdf.save();
    }

    try {
      final dataPrint = await show();
      showDialog(
        context: context,
        builder: (context) => PrinterDialogPhone(data: dataPrint),
      );
    } catch (e) {
      // Handle any exceptions here
      Log.e(e);
    }
  }

  // patchPay(String isOrder, OrdersEntity orders, List<int> list) {
  //   Log.w("Patch Pay");
  //   final state = context.read<CartBloc>().state;
  //   OrderPayModel param = OrderPayModel(
  //     id: isOrder,
  //     paymentinorderSet: [
  //       {
  //         "method": 1,
  //         "cost":
  //             state.discount - (orders.prepaidAmount + orders.insertedValue) > 0
  //                 ? state.discount -
  //                     (orders.prepaidAmount + orders.insertedValue)
  //                 : 0
  //       }
  //     ],
  //     action: state.allPrice == 0 ? "pay" : "in_advance",
  //     status: 2,
  //   );

  //   context.read<CartBloc>().add(PatchPay(
  //         param: param,
  //         onSuccess: () {
  //           context.read<OrdersBloc>().add(GetOrders(
  //                 nullSearch: true,
  //                 search: orders.number.toString(),
  //                 onSuccess: (value) {
  //                   context.read<OrdersBloc>().add(GetOrderProduct(
  //                         id: orders.id,
  //                         index: value.indexWhere(
  //                                     (element) => element.id == orders.id) ==
  //                                 -1
  //                             ? 0
  //                             : value.indexWhere(
  //                                 (element) => element.id == orders.id),
  //                         onSuccess: (order) async {
  //                           context.pop();
  //                           await ticketUpdate(order, list);
  //                           vm.task.clear();
  //                           context.read<CartBloc>().add(CartRemove());
  //                           context
  //                               .read<MyNavigatorBloc>()
  //                               .add(OpenCart(false));
  //                           // context.read<ShowPopUpBloc>().add(ShowPopUp(
  //                           //     message: "Buyurtma yangilandi", status: PopStatus.success));
  //                           // vm.isChanged = false;
  //                           // context.read<GoodsBloc>().add(GetOrgProduct(isLoading: false));
  //                           widget.vm.clearAccount(context);
  //                           vm.controllerComment.clear();
  //                         },
  //                       ));
  //                 },
  //               ));
  //         },
  //         onError: (error) {
  //           context.read<ShowPopUpBloc>().add(ShowPopUp(
  //                 message: error,
  //                 status: PopStatus.error,
  //               ));
  //         },
  //       ));
  // }

  void updateOrder({
    required Map<int, OrgProductEntity> cartMap,
    required String selUsername,
    required String username,
    required OrdersEntity orders,
    required List<ListCount> counts,
    required String isOrder,
  }) {
    if (isOrder.isEmpty) {
      final state = context.read<CartBloc>().state;
      if (selUsername.isEmpty) {
        context
            .read<ShowPopUpBloc>()
            .add(ShowPopUp(message: "Select user", status: PopStatus.error));
      } else {
        context.read<CartBloc>().add(
              CreatOrder(
                isCupon: vm.isCupon,
                username: selUsername.isNotEmpty ? selUsername : null,
                filter: PostProductFilter(
                  clientComment: vm.controllerComment.text,
                  method: state.allPrice == 0,
                  info: {
                    "task": List.generate(
                      vm.task.length,
                      (index) => {
                        "id": vm.task[index].index,
                        "comment": vm.task[index].controller.text,
                        "date_time": vm.task[index].dateTime.toString(),
                        "end_time": vm.task[index].dateTime.toString(),
                        "is_succes": false,
                        "type": "false",
                      },
                    ),
                    "count": vm.task.length,
                    "finish_count": 0
                  },
                ),
                onError: (nima) {
                  context
                      .read<ShowPopUpBloc>()
                      .add(ShowPopUp(message: nima, status: PopStatus.error));
                },
                onSuccess: (data) async {
                  context.pop();
                  await ticket(data);
                  // context.read<GoodsBloc>().add(GetOrgProduct(isLoading: false));
                  // context.read<ShowPopUpBloc>().add(ShowPopUp(
                  //       message: MyFunctions.createPrice(context),
                  //       status: PopStatus.success,
                  //     ));
                  widget.vm.clearAccount(context);
                },
              ),
            );
      }
    } else {
      context.pop();
      vm.task.clear();
      context.read<CartBloc>().add(CartRemove());
      vm.isChanged = false;
      widget.vm.clearAccount(context);
      vm.controllerComment.clear();
    }
  }

  createOrders(AccountsState stateAccount) {
    context.read<CartBloc>().add(
          CreatOrder(
            isCupon: true,
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
