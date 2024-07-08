import 'package:go_router/go_router.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/post_product_filter.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/card_list_iteam.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/payme_dialog.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/entity/orders_entity.dart';
import 'package:tmed_kiosk/features/common/navigation/routs_contact.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/features/common/ticket/recept_roll_80.dart';
import 'package:tmed_kiosk/features/common/ticket/tickets/recept_roll_product.dart';
import 'package:tmed_kiosk/features/common/ticket/w_dialog_printer.dart';
import 'package:tmed_kiosk/features/common/widgets/dialog_title.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/list_count.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/tts_controller_mixin.dart';

mixin CartMixin on State<CardListIteam> {
  late final vm = widget.vm;
  TTSControllerMixin controllerMixin = TTSControllerMixin();

  void onBarcode(String barcode) {
    context.read<GoodsBloc>().add(PrBarCode(
          barcode,
          onSucces: (resaul) {
            context.read<CartBloc>().add(CartAddMap(resaul, 0, isCart: true));
          },
          onError: (value) {
            context
                .read<ShowPopUpBloc>()
                .add(ShowPopUp(message: value, status: PopStatus.error));
          },
        ));
  }

  checkUser({
    required Map<int, OrgProductEntity> cartMap,
    required String selUsername,
    required String username,
    required BuildContext context,
  }) {
    bool isProduct = false;
    for (var i = 0; i < cartMap.length; i++) {
      if (cartMap[(cartMap.keys).toList()[i]]!.product.type.name != 'product' &&
          selUsername.isEmpty &&
          username.isEmpty) {
        isProduct = true;
      }
    }
    if (!isProduct) {
      controllerMixin.speak("Отсканируйте QR код с вашего приложения");
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: context.color.backGroundColor,
          insetPadding: const EdgeInsets.all(24),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const DialogTitle(title: "Tolov turini tanlang"),
          content: PaymeDialog(
            bloc: context.read<CartBloc>(),
            vm: widget.vm,
            vmA: widget.vmA,
            goodsBloc: context.read<GoodsBloc>(),
            username: context
                .read<AccountsBloc>()
                .state
                .selectAccount
                .selectAccount
                .username,
            context: context,
          ),
        ),
      );
      // context.read<MyNavigatorBloc>().add(NavId(2));
    } else {
      context.push(RoutsContact.userAdd, extra: widget.vmA);
    }
  }

  void createOrder({
    required Map<int, OrgProductEntity> cartMap,
    required String selUsername,
    required String username,
    required OrdersEntity orders,
    required List<ListCount> counts,
    required String isOrder,
  }) {
    context.read<CartBloc>().add(
          CreatOrder(
            isCupon: widget.vm.isCupon,
            username: selUsername.isNotEmpty ? selUsername : null,
            filter: PostProductFilter(
              clientComment: vm.controllerComment.text,
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
              await ticket(data);
              vm.task.clear();
              context.read<MyNavigatorBloc>().add(OpenCart(false));
              // context.read<ShowPopUpBloc>().add(ShowPopUp(
              //       message: MyFunctions.createPrice(context),
              //       status: PopStatus.success,
              //     ));
              // context.read<GoodsBloc>().add(GetOrgProduct(isLoading: false));
              widget.vmA.clearAccount(context);
              vm.controllerComment.clear();
            },
          ),
        );
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
        builder: (context) => PrinterDialog(data: dataPrint),
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
            bold: Font.ttf(
                await rootBundle.load("assets/fonts/NotoSans-Bold.ttf")),
            base: Font.ttf(
                await rootBundle.load("assets/fonts/NotoSans-Regular.ttf")),
            italic: Font.ttf(
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
        builder: (context) => PrinterDialog(data: dataPrint),
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
  //                           widget.vmA.clearAccount(context);
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
      context.read<CartBloc>().add(
            CreatOrder(
              isCupon: widget.vm.isCupon,
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
                await ticket(data);
                // context.read<GoodsBloc>().add(GetOrgProduct(isLoading: false));
                context.read<MyNavigatorBloc>().add(NavId(0));
                context.read<MyNavigatorBloc>().add(OpenCart(false));
                // context.read<ShowPopUpBloc>().add(ShowPopUp(
                //       message: MyFunctions.createPrice(context),
                //       status: PopStatus.success,
                //     ));
                widget.vmA.clearAccount(context);
              },
            ),
          );
    } else {
      vm.task.clear();
      context.read<CartBloc>().add(CartRemove());
      context.read<MyNavigatorBloc>().add(OpenCart(false));
      vm.isChanged = false;
      widget.vmA.clearAccount(context);
      vm.controllerComment.clear();
    }
  }
}
