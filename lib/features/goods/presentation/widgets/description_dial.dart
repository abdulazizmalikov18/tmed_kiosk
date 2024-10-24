import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/card_list_iteam.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/goods_view_model.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/dialog_goods_psp.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class DescriptionDialog extends StatelessWidget {
  const DescriptionDialog({
    super.key,
    this.isImage = true,
    required this.product,
    required this.isLiked,
    this.isPhone = false,
    required this.vm,
    required this.isPrice,
    required this.bloc,
    required this.blocCart,
  });

  final OrgProductEntity product;
  final GoodsBloc bloc;
  final bool isImage;
  final bool isLiked;
  final bool isPhone;
  final GoodsViewModel vm;
  final bool isPrice;
  final CartBloc blocCart;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (product.product.images.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemCount: product.product.images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      color: whiteGrey,
                      height: 100,
                      width: 100,
                      child: Image.network(
                        product.product.images[index].file,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, url, error) => const SizedBox(),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              product.product.name,
              style: AppTheme.bodyMedium.copyWith(fontSize: 20, color: context.color.white),
            ),
            Divider(color: context.color.white.withOpacity(.1)),
            const SizedBox(height: 12),
            if (product.productFeatures.isNotEmpty)
              //   Column(
              //     mainAxisSize: MainAxisSize.min,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "${LocaleKeys.parameter.tr()}:",
              //         style: AppTheme.bodyLarge.copyWith(color: context.color.white),
              //       ),
              //       ...List.generate(
              //         product.productFeatures.length,
              //         (index) => Row(
              //           children: [
              //             Text(
              //               "${product.productFeatures[index].feature.name}: ",
              //               style: AppTheme.labelSmall.copyWith(color: context.color.white),
              //             ),
              //             ...List.generate(
              //               product.productFeatures[index].preparedValue.length,
              //               (index) => Text(
              //                 product.productFeatures[index].preparedValue[index]
              //                     .value,
              //                 style: AppTheme.titleLarge.copyWith(color: context.color.white50),
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // const SizedBox(height: 12),
              Text(
                "${LocaleKeys.description.tr()}: ",
                style: AppTheme.bodyLarge.copyWith(color: context.color.white),
              ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: AppTheme.labelSmall,
            ),
            if (product.product.type.name == "product")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "${LocaleKeys.responsible_employees.tr()}:",
                      style: AppTheme.bodyLarge.copyWith(color: context.color.white),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${LocaleKeys.offerpage_in_stock.tr()}: ",
                        style: AppTheme.labelSmall.copyWith(color: context.color.white),
                      ),
                      Text(
                        "${product.remains}",
                        style: AppTheme.titleLarge,
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      text: "${LocaleKeys.offer_place.tr()}: ",
                      style: AppTheme.labelSmall.copyWith(color: context.color.white),
                      children: [
                        TextSpan(
                          text: product.placeDesc,
                          style: AppTheme.titleLarge,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              )
            else
              DialogGoodsPsp(bloc: bloc),
            const SizedBox(height: 16),
            WButton(
              onTap: () {
                vm.onSelectionCart(
                  context,
                  product: product,
                  isPhone: isPhone,
                  isLiked: isLiked,
                  isPrice: isPrice,
                  bloc: bloc,
                  blocCart: blocCart,
                );
                context.pop();
              },
              height: 80,
              text: LocaleKeys.checkout.tr(),
              textStyle: const TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
