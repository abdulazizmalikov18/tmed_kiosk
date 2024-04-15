import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/common/widgets/dialog_title.dart';
import 'package:tmed_kiosk/features/common/widgets/w_text_gard.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/list_count.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/show_select.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/show_count_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartListIteamNoPrice extends StatefulWidget {
  const CartListIteamNoPrice({
    super.key,
    required this.index,
    required this.product,
    required this.vm,
    required this.counts,
    required this.allPrice,
    required this.discount,
    required this.bloc,
  });
  final int index;
  final OrgProductEntity product;
  final CartViewModel vm;
  final List<ListCount> counts;
  final int allPrice;
  final int discount;
  final GoodsBloc bloc;

  @override
  State<CartListIteamNoPrice> createState() => _CartListIteamNoPriceState();
}

class _CartListIteamNoPriceState extends State<CartListIteamNoPrice> {
  late final vm = widget.vm;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: wdecoration2,
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.product.product.name,
                  style: AppTheme.displayLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 12),
              if (widget.counts[widget.index].psp != null)
                WTextGrad(
                    text: widget.counts[widget.index].psp!.specialist.name),
            ],
          ),
          Divider(color: white.withOpacity(.1), height: 20),
          SizedBox(
            height: 28,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: greyText),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (widget.counts[widget.index].count > 1) {
                            vm.countEdit(
                              context: context,
                              isRemove: true,
                              index: widget.index,
                              counts: widget.counts,
                              controller: controller,
                              allP: widget.allPrice,
                              disP: widget.discount,
                              prices: widget.product.prices,
                            );

                            setState(() {});
                          } else {
                            context
                                .read<CartBloc>()
                                .add(CartAddMap(widget.product, widget.index));
                          }
                        },
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: AppIcons.minusCircle.svg(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ShowCountEdit(
                              controller: controller,
                              maxCount: widget.product.remains,
                            ),
                          ).then((value) {
                            if (value == true) {
                              vm.countEditText(
                                context,
                                controller: controller,
                                list: widget.counts,
                                index: widget.index,
                                allP: widget.allPrice,
                                disP: widget.discount,
                                prices: widget.product.prices,
                              );
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            "x ${widget.counts[widget.index].count} Vazifa",
                            style: AppTheme.displayLarge,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: () {
                          if (widget.product.remains >
                                  widget.counts[widget.index].count ||
                              widget.product.remains == 0) {
                            vm.countEdit(
                              context: context,
                              isRemove: false,
                              index: widget.index,
                              counts: widget.counts,
                              controller: controller,
                              allP: widget.allPrice,
                              disP: widget.discount,
                              prices: widget.product.prices,
                            );
                            setState(() {});
                          }
                        },
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: AppIcons.addCircle
                              .svg(color: white.withOpacity(.5)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 26,
                  width: 26,
                  child: IconButton(
                    onPressed: () {
                      if (widget.product.product.type.name != 'product') {
                        context
                            .read<GoodsBloc>()
                            .add(GetPsp(widget.product.id));
                      } else {
                        context
                            .read<GoodsBloc>()
                            .add(GetSupplies(widget.product.id));
                      }
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(24, 12, 24, 24),
                          title: const DialogTitle(title: "Vazifa haqida"),
                          content: ShowSelect(
                            isProduct:
                                widget.product.product.type.name == 'product',
                            isDiscount: widget.product.prices.isEmpty
                                ? false
                                : widget.product.prices[0].discount > 0,
                            product: widget.product,
                            mydate: widget.counts[widget.index].dateTime,
                            index: widget.index,
                            isCart: true,
                            selectIndex:
                                widget.counts[widget.index].selectIndex,
                            dataIndex: widget.counts[widget.index].dataIndex,
                            isPrice: false,
                            bloc: widget.bloc,
                            cartBloc: context.read<CartBloc>(),
                          ),
                        ),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                    padding: const EdgeInsets.all(0),
                    icon: SvgPicture.asset(
                      AppIcons.arrowDown,
                      colorFilter: const ColorFilter.mode(
                        white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
