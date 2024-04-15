import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/card_list_iteam.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin CartMixin on State<CardListIteam> {
  late final vm = widget.vm;

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
      context.read<MyNavigatorBloc>().add(NavId(2));
    } else {
      context
          .read<ShowPopUpBloc>()
          .add(ShowPopUp(message: "User tanlang", status: PopStatus.error));
    }
  }
}
