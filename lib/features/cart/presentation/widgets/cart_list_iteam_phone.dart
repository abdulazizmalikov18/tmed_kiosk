import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/common/navigation/presentation/navigator.dart';
import 'package:tmed_kiosk/features/common/widgets/w_price_row.dart';
import 'package:tmed_kiosk/features/common/widgets/w_text_gard.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/goods/presentation/views/selection_special.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/show_count_edit.dart';

class CartListIteamPhone extends StatefulWidget {
  const CartListIteamPhone({
    super.key,
    required this.index,
    required this.product,
    required this.vm,
  });
  final int index;
  final OrgProductEntity product;
  final CartViewModel vm;

  @override
  State<CartListIteamPhone> createState() => _CartListIteamPhoneState();
}

class _CartListIteamPhoneState extends State<CartListIteamPhone> {
  late final vm = widget.vm;
  SplashColors localPress = SplashColors.none;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    setLocalPress(SplashColors.none);
  }

  void setLocalPress(SplashColors enumes) {
    setState(() => localPress = enumes);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: wboxShadow,
            color: contColor,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(8),
            color: contColor,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTapDown: (onTabPosition) {
                if (width * 0.3 >= onTabPosition.localPosition.dx.toInt()) {
                  setLocalPress(SplashColors.red);
                  if (state.counts[widget.index].count > 1) {
                    vm.countEdit(
                      context: context,
                      isRemove: true,
                      index: widget.index,
                      counts: state.counts,
                      controller: controller,
                      allP: state.allPrice,
                      disP: state.discount,
                      prices: widget.product.prices,
                    );
                  } else {
                    context
                        .read<CartBloc>()
                        .add(CartAddMap(widget.product, widget.index));
                  }
                } else if (width * 0.6 <=
                    onTabPosition.localPosition.dx.toInt()) {
                  setLocalPress(SplashColors.blue);
                  if (widget.product.remains >
                          state.counts[widget.index].count ||
                      widget.product.remains == 0) {
                    vm.countEdit(
                      context: context,
                      isRemove: false,
                      index: widget.index,
                      counts: state.counts,
                      controller: controller,
                      allP: state.allPrice,
                      disP: state.discount,
                      prices: widget.product.prices,
                    );
                  }
                } else {
                  setLocalPress(SplashColors.none);
                  showDialog(
                    context: context,
                    builder: (context) => ShowCountEdit(
                      controller: controller,
                      maxCount: widget.product.remains,
                    ),
                  ).then((value) {
                    setState(() {});
                    if (value == true) {
                      vm.countEditText(
                        context,
                        controller: controller,
                        list: state.counts,
                        index: widget.index,
                        allP: state.allPrice,
                        disP: state.discount,
                        prices: widget.product.prices,
                      );
                    }
                  });
                }
              },
              focusColor: Colors.orange,
              hoverColor: white,
              splashColor: localPress == SplashColors.red
                  ? red
                  : localPress == SplashColors.blue
                      ? green
                      : longGrey,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.product.product.name,
                          style: AppTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const Spacer(),
                        if (state.counts[widget.index].psp != null)
                          WTextGrad(
                            text:
                                state.counts[widget.index].psp!.specialist.name,
                          ),
                      ],
                    ),
                    const Divider(color: whiteGrey),
                    const SizedBox(height: 4),
                    WPriceRow(
                      product: widget.product,
                      count: state.counts[widget.index],
                      isPhone: true,
                      vm: vm,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Vazifa haqida: x${state.counts[widget.index].count}',
                      style: AppTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total: ${MyFunctions.getThousandsSeparatedPrice(state.counts[widget.index].allPrice.toString())} UZS',
                          style: AppTheme.displayLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const Spacer(),
                        Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.only(left: 12),
                          child: IconButton(
                            onPressed: () {
                              if (widget.product.product.type.name !=
                                  'product') {
                                context
                                    .read<GoodsBloc>()
                                    .add(GetPsp(widget.product.id));
                              } else {
                                context
                                    .read<GoodsBloc>()
                                    .add(GetSupplies(widget.product.id));
                              }
                              Navigator.of(context)
                                  .push(
                                fade(
                                  page: SelectionSpecialData(
                                    isProduct:
                                        widget.product.product.type.name ==
                                            'product',
                                    isDiscount:
                                        widget.product.prices[0].discount > 0 ||
                                            widget.product.prices[0].value !=
                                                state
                                                    .counts[widget.index].price,
                                    product: widget.product,
                                    mydate: state.counts[widget.index].dateTime,
                                    index: widget.index,
                                    isCart: true,
                                    selectIndex:
                                        state.counts[widget.index].selectIndex,
                                    dataIndex:
                                        state.counts[widget.index].dataIndex,
                                  ),
                                ),
                              )
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            padding: const EdgeInsets.all(0),
                            icon: AppIcons.arrowDown.svg(color: white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
