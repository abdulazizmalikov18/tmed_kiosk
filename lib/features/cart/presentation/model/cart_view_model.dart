import 'package:tmed_kiosk/features/cart/presentation/model/task_create_model.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/list_count.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/price_entity.dart';
import 'package:tmed_kiosk/features/main/domain/entity/price_entity.dart';

class CartViewModel {
  TextEditingController controller = TextEditingController();
  TextEditingController controllerComment = TextEditingController();
  List<TaskCreateModel> task = [];
  int allPrice = 0;
  int discount = 0;
  int start = 0;
  int moneyEntered = 0;

  bool isCupon = false;
  bool isDeliveriy = false;
  bool isChanged = false;

  void closePay() {
    moneyEntered = 0;
  }

  void cuponSelction({
    required BuildContext context,
    required CuponModel cupon,
    required List<ListCount> counts,
    required Map<int, OrgProductEntity> cartMap,
  }) {
    allPrice = 0;
    discount = 0;
    for (var i = 0; i < counts.length; i++) {
      counts[i].price = cartMap[counts[i].id]!.prices[0].discountPrice == 0
          ? cartMap[counts[i].id]!.prices[0].value.toInt()
          : cartMap[counts[i].id]!.prices[0].discountPrice.toInt();
      if (MyFunctions.isCupon(cupon, counts[i].id)) {
        counts[i].cuponPrice = cupon.productDiscount.toInt();
        counts[i].discountPrice = cupon.productDiscount.toInt() * (-1);
        double discoun = cupon.productDiscount / 100;
        if (discoun == 1) {
          discoun = 0;
        }
        double disDiscount = 1 - discoun;
        counts[i].discount =
            counts[i].count * (counts[i].price * disDiscount).toInt();
        counts[i].price = (counts[i].price * discoun).toInt();
      } else {
        counts[i].discountPrice = 0;
        counts[i].discount = cartMap[counts[i].id]!.prices[0].discount;
        counts[i].cuponPrice = 0;
      }
      counts[i].allPrice = counts[i].count * counts[i].price;
      allPrice += counts[i].allPrice;
      discount += counts[i].discount;
    }
    context.read<CartBloc>().add(CountEdit(counts, allPrice, discount));
  }

  void checkPrice(
    List<MyPriceEntity> list,
    int price,
    int index,
  ) {
    int calculationPrice = 0;
    for (var i = 1; i < list.length; i++) {
      if (list[i].controller.text.isNotEmpty) {
        calculationPrice +=
            int.parse(list[i].controller.text.replaceAll(" ", ""));
      }
    }
    moneyEntered = calculationPrice;
  }

  void textPrice(List<MyPriceEntity> list, int price, int index, int avans) {
    checkPrice(list, price, index);
    if (index != 0 && list[index].controller.text.isEmpty) {
      int hullas = price - moneyEntered - avans;
      if (hullas != 0 && 0 < hullas) {
        list[index].controller.text = MyFunctions.priceFormat(hullas);
      }
    }
    checkPrice(list, price, index);
  }

  void countEdit({
    required BuildContext context,
    required bool isRemove,
    required int index,
    required List<ListCount> counts,
    required TextEditingController controller,
    required int allP,
    required int disP,
    required List<PriceEntity> prices,
  }) {
    List<ListCount> count = List.from(counts);
    allPrice = allP;
    discount = disP;
    Log.w("message 1");
    if (isRemove) {
      count[index].count = count[index].count - 1;
      allPrice -= count[index].price;
      discount -= count[index].discount;
      count[index].allPrice = count[index].price;
    } else {
      count[index].count = count[index].count + 1;
      allPrice += count[index].price;
      discount += count[index].discount;
      count[index].allPrice += count[index].price;
    }
    if (count[index].discount == 0) {
      count = _calPriceOpt(prices, count, index);
    }
    isChanged = true;
    controller.text = count[index].count.toString();
    context.read<CartBloc>().add(CountEdit(count, allPrice, discount));
  }

  void countEditText(
    BuildContext context, {
    required TextEditingController controller,
    required List<ListCount> list,
    required int index,
    required int allP,
    required int disP,
    required List<PriceEntity> prices,
  }) {
    List<ListCount> counts = List.from(list);
    allPrice = allP;
    discount = disP;
    allPrice -= counts[index].count * counts[index].price;
    discount -= counts[index].count * counts[index].discount;
    counts[index].count = int.parse(controller.text);
    if (counts[index].discount == 0) {
      for (var i = 0; i < prices.length; i++) {
        if (prices[i].minQty != null) {
          if (counts[index].count >= prices[i].minQty!.toInt() &&
                  counts[index].count <= prices[i].maxQty!.toInt() ||
              counts[index].count > prices[i].maxQty!.toInt() &&
                  i == prices.length - 1) {
            counts[index].discount = prices[i].discount.toInt();
            counts[index].price = prices[i].value.toInt();
            counts[index].priceIndex = i;
          }
        }
      }
    }
    counts[index].allPrice = counts[index].count * counts[index].price;
    allPrice += counts[index].allPrice;
    discount += counts[index].count * counts[index].discount;
    context.read<CartBloc>().add(CountEdit(counts, allPrice, discount));
  }

  List<ListCount> _calPriceOpt(
      List<PriceEntity> prices, List<ListCount> counts, int index) {
    for (var i = 0; i < prices.length; i++) {
      Log.w("MinQTY: ${prices[i].minQty}");
      Log.w("MaxQTY: ${prices[i].maxQty}");
      if (prices[i].minQty != null) {
        final maxQty = prices[i].maxQty == null ? 1 : prices[i].maxQty!.toInt();
        if (counts[index].count >= prices[i].minQty!.toInt() &&
                counts[index].count <= maxQty ||
            counts[index].count > maxQty && i == prices.length - 1) {
          allPrice -= counts[index].count * counts[index].price;
          discount -= counts[index].count * counts[index].discount;
          if (counts[index].cuponPrice == 0) {
            counts[index].discount = prices[i].discount.toInt();
            counts[index].price = prices[i].value.toInt();
            counts[index].priceIndex = i;
          }
          counts[index].allPrice = counts[index].count * counts[index].price;
          allPrice += counts[index].allPrice;
          discount += counts[index].count * counts[index].discount;
        }
      }
    }
    return counts;
  }

  String price({required ListCount count, required OrgProductEntity product}) {
    String discountP = "";
    if (count.priceIndex > 0) {
      discountP =
          MyFunctions.getThousandsSeparatedPrice(count.price.toString());
    } else {
      int discount = count.discountPrice;

      discountP = MyFunctions.discount(
        discount == 0
            ? product.prices.isNotEmpty
                ? (product.prices[0].discount * (-1))
                : 0
            : discount,
        product.prices.isNotEmpty ? product.prices[0].value.toInt() : 0,
      );
    }

    return discountP;
  }
}

enum SplashColors { none, blue, red }
