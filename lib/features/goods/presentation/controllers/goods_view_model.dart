import 'package:easy_localization/easy_localization.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/common/navigation/presentation/navigator.dart';
import 'package:tmed_kiosk/features/common/widgets/dialog_title.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/presentation/views/selection_special.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/show_select.dart';

class GoodsViewModel {
  void onSelectionCart(
    BuildContext context, {
    required OrgProductEntity product,
    required bool isPhone,
    required bool isLiked,
    required bool isPrice,
    required GoodsBloc bloc,
    required CartBloc blocCart,
    bool isInformation = false,
  }) {
    final isProduct = product.product.type.name == 'product';
    if (!isInformation) {
      if (isProduct) {
        if (product.remains != 0) {
          blocCart.add(CartAddMap(product, 0));
        }
      } else {
        blocCart.add(CartAddMap(product, 0));
      }
    } else {
      if (isProduct ? product.remains != 0 : true) {
        if (isPhone) {
          Navigator.of(context).push(fade(
              page: SelectionSpecialData(
            isProduct: !isProduct,
            isDiscount: product.prices.isEmpty ? false : product.prices.first.discount > 0,
            product: product,
          )));
        } else {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              backgroundColor: context.color.backGroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              title: DialogTitle(title: "special_parameters".tr()),
              content: ShowSelect(
                isProduct: isProduct,
                isDiscount: product.prices.isEmpty ? false : product.prices.first.discount > 0,
                product: product,
                isCart: isLiked,
                isPrice: isPrice,
                bloc: bloc,
                cartBloc: blocCart,
              ),
            ),
          );
        }
      }
    }
  }
}
