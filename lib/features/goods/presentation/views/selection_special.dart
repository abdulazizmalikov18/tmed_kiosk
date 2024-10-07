import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/psp_viewer.dart';

import 'package:tmed_kiosk/features/goods/presentation/widgets/supplies_shimmer.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SelectionSpecialData extends StatefulWidget {
  const SelectionSpecialData({
    super.key,
    required this.isProduct,
    required this.isDiscount,
    required this.product,
    this.selectIndex,
    this.dataIndex = -1,
    this.mydate,
    this.index = 0,
    this.isCart = false,
  });
  final bool isProduct;
  final bool isDiscount;
  final OrgProductEntity product;
  final int? selectIndex;
  final int? dataIndex;
  final DateTime? mydate;
  final int index;
  final bool isCart;

  @override
  State<SelectionSpecialData> createState() => _SelectionSpecialDataState();
}

class _SelectionSpecialDataState extends State<SelectionSpecialData> {
  late int selectedIndex;

  late int dataIndex;
  late DateTime mydate;
  bool weekDayEmpty = false;
  bool selction = false;
  int pricePercent = 0;
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    if (widget.product.product.type.name != 'product') {
      context.read<GoodsBloc>().add(GetPsp(widget.product.id));
    }
    selectedIndex = widget.selectIndex ?? 0;
    dataIndex = widget.dataIndex ?? -1;
    mydate = widget.mydate ?? DateTime.now();
    if (widget.product.prices.isNotEmpty) {
      pricePercent = (widget.product.prices.first.discountPrice ~/ 100) *
          selectedIndex.toInt();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoodsBloc, GoodsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tanla'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<PriceBloc, PriceState>(
                  builder: (context, state) {
                    if (state.isPrice) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: wdecoration2.copyWith(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${MyFunctions.getThousandsSeparatedPrice(widget.product.prices[0].discountPrice.toString())} UZS",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        (widget.product.prices[0]
                                                            .discountPrice /
                                                        100) *
                                                    selectedIndex >=
                                                0
                                            ? "+$pricePercent  UZS"
                                            : "$pricePercent  UZS",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTheme.bodyLarge.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: (widget.product.prices[0]
                                                              .discountPrice /
                                                          100) *
                                                      selectedIndex >=
                                                  0
                                              ? green
                                              : red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 76,
                                  child: VerticalDivider(color: borderColor),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${MyFunctions.getThousandsSeparatedPrice((widget.product.prices[0].discountPrice + ((widget.product.prices[0].discountPrice / 100) * selectedIndex)).toString())} UZS",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "${LocaleKeys.percentage.tr()} $selectedIndex%",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTheme.bodyLarge.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 120,
                            child: SfSlider(
                              onChanged: (value) {
                                double number =
                                    double.tryParse(value.toString()) ?? 0.0;
                                selectedIndex = number.toInt();
                                pricePercent =
                                    (widget.product.prices[0].discountPrice ~/
                                            100) *
                                        selectedIndex.toInt();
                                selction = true;
                                setState(() {});
                              },
                              min: -100,
                              max: 100,
                              interval: 20,
                              showLabels: true,
                              value: selectedIndex,
                              shouldAlwaysShowTooltip: true,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                if (widget.isProduct)
                  if (state.status2.isInProgress)
                    Wrap(
                      children: List.generate(
                        3,
                        (index) => const SuppliesShimmer(),
                      ),
                    )
                  else
                    Wrap(
                      children: List.generate(
                        state.supplies.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              dataIndex = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),
                            margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            decoration: BoxDecoration(
                              boxShadow: wboxShadow,
                              color: dataIndex == index ? null : white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              MyFunctions.parseDate(
                                state.supplies[index].expiryDate,
                              ),
                              style: AppTheme.labelSmall.copyWith(
                                color: dataIndex == index ? white : greyText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                else if (state.psp.isNotEmpty || state.status2.isInProgress)
                  PspViewer(
                    bloc: context.read<GoodsBloc>(),
                    dataIndex: widget.dataIndex,
                    mydate: widget.mydate,
                    onDateChange: (date) {
                      mydate = date;
                      setState(() {
                        selction = true;
                      });
                    },
                    onChangePsp: (index) {
                      setState(() {
                        dataIndex = index;
                      });
                    },
                  )
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: contColor,
              boxShadow: wboxShadow,
            ),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: WButton(
              onTap: () {
                if (widget.isCart) {
                  context.read<CartBloc>().add(
                        CartEdit(
                          widget.product,
                          widget.index,
                          dateTime: widget.isProduct && dataIndex >= 0
                              ? DateTime.parse(
                                  state.supplies[dataIndex].expiryDate)
                              : mydate,
                          supplies: widget.isProduct && dataIndex >= 0
                              ? state.supplies[dataIndex].id
                              : null,
                          discountPrice: selectedIndex,
                          selectIndex: selectedIndex,
                          dataIndex: dataIndex,
                          pricePercent: pricePercent,
                        ),
                      );
                } else {
                  context.read<CartBloc>().add(
                        CartAddMap(
                          widget.product,
                          0,
                          dateTime: widget.isProduct && dataIndex >= 0
                              ? DateTime.parse(
                                  state.supplies[dataIndex].expiryDate)
                              : mydate,
                          supplies: widget.isProduct && dataIndex >= 0
                              ? state.supplies[dataIndex].id
                              : null,
                          discountPrice: selectedIndex,
                          selectIndex: selectedIndex,
                          dataIndex: dataIndex,
                          pricePercent: pricePercent,
                        ),
                      );
                }
                Navigator.pop(context);
              },
              text: "Tanlang",
              isDisabled: !widget.isProduct && !selction,
            ),
          ),
        );
      },
    );
  }
}
