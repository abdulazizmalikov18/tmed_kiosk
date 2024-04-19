import 'package:go_router/go_router.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/card_list_iteam.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/payme_dialog.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/navigation/routs_contact.dart';
import 'package:tmed_kiosk/features/common/widgets/dialog_title.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
}
