import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/list_count.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';

class WPriceRow extends StatelessWidget {
  const WPriceRow({
    super.key,
    required this.product,
    this.widget,
    required this.count,
    required this.vm,
    this.color = white,
    this.isPhone = false,
  });

  final OrgProductEntity product;
  final Widget? widget;
  final ListCount count;
  final CartViewModel vm;
  final Color color;
  final bool isPhone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 150),
          child: Text(
            MyFunctions.getProductType(product.product.type.name) !=
                    ProductType.task
                ? '${vm.price(count: count, product: product)} UZS'
                : "--",
            style: isPhone
                ? AppTheme.bodyLarge
                    .copyWith(color: color, fontWeight: FontWeight.w400)
                : AppTheme.displayLarge.copyWith(color: color),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        if (product.prices.isNotEmpty &&
                MyFunctions.getProductType(product.product.type.name) !=
                    ProductType.task
            ? product.prices.first.discount > 0 ||
                count.discountPrice != 0 ||
                count.priceIndex != 0
            : false)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            constraints: const BoxConstraints(maxWidth: 140),
            child: Text(
              '${MyFunctions.getThousandsSeparatedPrice(product.prices.first.value.toString())} ${product.prices.first.currency.toUpperCase()}',
              style: AppTheme.displayLarge.copyWith(
                color: red,
                decoration: TextDecoration.lineThrough,
                fontWeight: isPhone ? FontWeight.w400 : FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        if (product.prices.isNotEmpty &&
                MyFunctions.getProductType(product.product.type.name) !=
                    ProductType.task
            ? product.prices.first.discount > 0 ||
                count.discountPrice != 0 && count.priceIndex == 0
            : false)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: count.discountPrice >= 0 ? green : red,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            child: Text(
              '${count.discountPrice != 0 ? MyFunctions.changeNegativeToPositive(count.discountPrice) : product.prices.first.discount} %',
              style: const TextStyle(color: white),
            ),
          ),
        const Spacer(),
        SizedBox(
          width: 40,
          child: widget,
        ),
      ],
    );
  }
}
