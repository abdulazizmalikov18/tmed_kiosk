import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/w_price_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/common/widgets/dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/list_count.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/goods_view_model.dart';
import 'package:tmed_kiosk/features/goods/presentation/views/ponarama_image_view.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/description_dial.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class WGoodsItem extends StatefulWidget {
  const WGoodsItem({
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

  final bool isImage;
  final OrgProductEntity product;
  final bool isLiked;
  final bool isPhone;
  final GoodsViewModel vm;
  final bool isPrice;
  final GoodsBloc bloc;
  final CartBloc blocCart;

  @override
  State<WGoodsItem> createState() => _WGoodsItemState();
}

class _WGoodsItemState extends State<WGoodsItem> {
  bool isNull = false;

  @override
  Widget build(BuildContext context) {
    isNull = widget.product.remains != 0 || widget.product.product.type.name != 'product';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: wboxShadow,
        color: isNull ? context.color.contColor : red,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    widget.vm.onSelectionCart(
                      context,
                      product: widget.product,
                      isPhone: widget.isPhone,
                      isLiked: widget.isLiked,
                      isPrice: widget.isPrice,
                      isInformation: true,
                      bloc: widget.bloc,
                      blocCart: widget.blocCart,
                    );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.product.name,
                            style: AppTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w500,
                              color: isNull ? context.color.white : white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: AppIcons.shoppingCart.svg(color: widget.isLiked ? blue : greyText),
                        )
                      ],
                    ),
                  ),
                ),
                if (widget.isImage) Divider(color: context.color.white.withOpacity(.1), height: 16),
                if (widget.isImage)
                  InkWell(
                    onTap: () {
                      if (widget.product.product.type.name != 'product') {
                        context.read<GoodsBloc>().add(GetPsp(widget.product.id));
                      }
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: context.color.backGroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: widget.isPhone ? const EdgeInsets.all(12) : const EdgeInsets.fromLTRB(24, 12, 24, 24),
                          insetPadding: const EdgeInsets.all(16),
                          titlePadding: widget.isPhone ? const EdgeInsets.all(12) : const EdgeInsets.fromLTRB(24, 12, 24, 24),
                          title: DialogTitle(
                            title: "about_the_task".tr(),
                            isBottom: false,
                          ),
                          content: DescriptionDialog(
                            product: widget.product,
                            isPhone: widget.isPhone,
                            isLiked: widget.isLiked,
                            isPrice: widget.isPrice,
                            bloc: widget.bloc,
                            blocCart: widget.blocCart,
                            vm: widget.vm,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 156,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: whiteGrey,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.product.product.image.file),
                          onError: (exception, stackTrace) => Image.asset(AppImages.logo),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Divider(color: context.color.white.withOpacity(.1), height: 16),
          InkWell(
            onTap: () {
              if (widget.product.product.type.name != 'product') {
                context.read<GoodsBloc>().add(GetPsp(widget.product.id));
              }
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: context.color.backGroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: widget.isPhone ? const EdgeInsets.all(12) : const EdgeInsets.fromLTRB(24, 12, 24, 24),
                  insetPadding: const EdgeInsets.all(16),
                  titlePadding: widget.isPhone ? const EdgeInsets.all(12) : const EdgeInsets.fromLTRB(24, 12, 24, 24),
                  title: DialogTitle(
                    title: "about_the_task".tr(),
                    isBottom: false,
                  ),
                  content: DescriptionDialog(
                    product: widget.product,
                    isPhone: widget.isPhone,
                    isLiked: widget.isLiked,
                    isPrice: widget.isPrice,
                    bloc: widget.bloc,
                    blocCart: widget.blocCart,
                    vm: widget.vm,
                  ),
                ),
              );
              // widget.vm.onSelectionCart(
              //   context,
              //   product: widget.product,
              //   isPhone: widget.isPhone,
              //   isLiked: widget.isLiked,
              //   isPrice: widget.isPrice,
              //   bloc: widget.bloc,
              //   blocCart: widget.blocCart,
              // );
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.isPrice)
                        WPriceRow(
                          color: context.color.white,
                          product: widget.product,
                          count: ListCount(),
                          isPhone: true,
                          vm: CartViewModel(),
                        ),
                      if (widget.isPrice) const SizedBox(height: 4),
                      if (widget.product.remains == 0 && widget.product.product.type.name != "product")
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.offerpage_in_stock.tr()}: ",
                              style: AppTheme.labelLarge.copyWith(color: isNull ? context.color.white.withOpacity(.5) : context.color.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            AppIcons.infinity.svg(height: 14, color: context.color.white)
                          ],
                        )
                      else
                        Text(
                          "${LocaleKeys.offerpage_in_stock.tr()}: ${widget.product.remains}",
                          style: AppTheme.labelLarge.copyWith(color: isNull ? context.color.white.withOpacity(.5) : context.color.white),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      if (widget.product.product.type.name == "offering")
                        Text(
                          "${LocaleKeys.offerpage_duration.tr()}: ${widget.product.duration == 0 ? "-" : widget.product.duration}",
                          style: AppTheme.labelLarge.copyWith(color: isNull ? context.color.white.withOpacity(.5) : context.color.white),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      if (widget.product.product.type.name == "product")
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.product.expiryDate.isNotEmpty)
                              Text(
                                "${LocaleKeys.offerpage_expiration_date.tr()}: ${MyFunctions.parseDate(widget.product.expiryDate)}",
                                style: AppTheme.labelLarge.copyWith(color: isNull ? context.color.white.withOpacity(.5) : context.color.white),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            Text(
                              "${LocaleKeys.offerpage_manufacturer.tr()}: ${widget.product.product.manufacturer.name.isEmpty ? "-" : widget.product.product.manufacturer.name}",
                              style: AppTheme.labelLarge.copyWith(color: isNull ? context.color.white.withOpacity(.5) : context.color.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              "${LocaleKeys.offerpage_offer_place.tr()}: ${widget.product.placeDesc.isEmpty ? "-" : widget.product.placeDesc}",
                              style: AppTheme.labelLarge.copyWith(color: isNull ? context.color.white.withOpacity(.5) : context.color.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              "${LocaleKeys.expiry_date.tr()}: -",
                              style: AppTheme.labelLarge.copyWith(color: isNull ? context.color.white.withOpacity(.5) : context.color.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        )
                    ],
                  ),
                ),
                if (widget.product.image360.isNotEmpty)
                  InkWell(
                    onTap: () {
                      if (Platform.isAndroid || Platform.isIOS) {
                        Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => PonaramaImageView(product: widget.product),
                        ));
                      } else {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: context.color.backGroundColor,
                            title: DialogTitle(
                              title: widget.product.product.name,
                              isBottom: false,
                            ),
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height - 120,
                              width: MediaQuery.of(context).size.width - 120,
                              child: InteractiveViewer(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: PanoramaViewer(
                                    animSpeed: .1,
                                    sensorControl: SensorControl.orientation,
                                    child: Image.network(widget.product.image360),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    child: AppIcons.image360.svg(height: 28, width: 28),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
