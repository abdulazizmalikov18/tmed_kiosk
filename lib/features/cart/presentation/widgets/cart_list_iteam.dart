import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/common/widgets/dialog_title.dart';
import 'package:tmed_kiosk/features/common/widgets/w_price_row.dart';
import 'package:tmed_kiosk/features/common/widgets/w_text_gard.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/show_select.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/show_count_edit.dart';

class CartListIteam extends StatefulWidget {
  const CartListIteam({
    super.key,
    required this.index,
    required this.product,
    required this.vm,
  });
  final int index;
  final OrgProductEntity product;
  final CartViewModel vm;

  @override
  State<CartListIteam> createState() => _CartListIteamState();
}

class _CartListIteamState extends State<CartListIteam> {
  late final vm = widget.vm;
  SplashColors localPress = SplashColors.none;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    setLocalPress(SplashColors.none);
  }

  void setLocalPress(SplashColors enumes) {
    setState(() {
      localPress = enumes;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.color.whiteBlack,
            border: Border.all(color: context.color.white.withOpacity(.1)),
          ),
          child: Material(
            borderRadius: BorderRadius.circular(8),
            color: context.color.whiteBlack,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTapDown: (onTabPosition) {
                if (width * 0.17 >= onTabPosition.localPosition.dx.toInt()) {
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
                } else if (width * 0.3 <=
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
                  } else {
                    context.read<ShowPopUpBloc>().add(ShowPopUp(
                          message: "Limitga yetdingiz",
                          status: PopStatus.warning,
                        ));
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
              hoverColor: context.color.whiteBlack,
              splashColor: localPress == SplashColors.red
                  ? red
                  : localPress == SplashColors.blue
                      ? green
                      : longGrey,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.product.product.name,
                          style: AppTheme.bodyMedium.copyWith(color: context.color.white),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const Spacer(),
                        if (state.counts[widget.index].psp != null)
                          WTextGrad(
                              text: state
                                  .counts[widget.index].psp!.specialist.name),
                      ],
                    ),
                    Divider(color: context.color.white.withOpacity(.1)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: WPriceRow(
                            color: context.color.white,
                            product: widget.product,
                            count: state.counts[widget.index],
                            vm: vm,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'x ${state.counts[widget.index].count} ${widget.product.product.unit.name}',
                            style: AppTheme.bodyLarge
                                .copyWith(fontWeight: FontWeight.w400, color: context.color.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                MyFunctions.getProductType(
                                            widget.product.product.type.name) !=
                                        ProductType.task
                                    ? '${MyFunctions.getThousandsSeparatedPrice((state.counts[widget.index].count * state.counts[widget.index].price).toString())} UZS'
                                    : "--",
                                style: AppTheme.bodyLarge.copyWith(color: context.color.white),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Container(
                                height: 26,
                                width: 26,
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
                                    changeCartIteam(context, state)
                                        .then((value) {
                                      vm.isChanged = true;
                                      setState(() {});
                                    });
                                  },
                                  padding: const EdgeInsets.all(0),
                                  icon: AppIcons.arrowDown.svg(color: context.color.white),
                                ),
                              ),
                            ],
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

  Future<dynamic> changeCartIteam(BuildContext context, CartState state) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        title: const DialogTitle(title: "Vazifa haqida"),
        content: ShowSelect(
          isProduct: widget.product.product.type.name == 'product',
          isDiscount: widget.product.prices.isEmpty
              ? false
              : widget.product.prices[0].discount > 0,
          product: widget.product,
          mydate: state.counts[widget.index].dateTime,
          index: widget.index,
          isCart: true,
          selectIndex: state.counts[widget.index].selectIndex,
          dataIndex: state.counts[widget.index].dataIndex,
          isPrice: context.read<PriceBloc>().state.isPrice,
          bloc: context.read<GoodsBloc>(),
          cartBloc: context.read<CartBloc>(),
        ),
      ),
    );
  }
}
