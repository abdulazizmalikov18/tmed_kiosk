import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/psp_viewer.dart';

class ShowSelect extends StatefulWidget {
  const ShowSelect({
    super.key,
    required this.isProduct,
    required this.isDiscount,
    required this.product,
    this.selectIndex,
    this.dataIndex = -1,
    this.mydate,
    this.index = 0,
    this.isCart = false,
    required this.isPrice,
    required this.bloc,
    required this.cartBloc,
  });
  final bool isProduct;
  final bool isDiscount;
  final OrgProductEntity product;
  final int? selectIndex;
  final int? dataIndex;
  final DateTime? mydate;
  final int index;
  final bool isCart;
  final bool isPrice;
  final GoodsBloc bloc;
  final CartBloc cartBloc;
  @override
  State<ShowSelect> createState() => _ShowSelectState();
}

class _ShowSelectState extends State<ShowSelect> {
  late int selectIndex;
  late int dataIndex;
  late DateTime mydate;
  int pricePercent = 0;
  bool selction = false;
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    if (widget.product.product.type.name != 'product') {
      widget.bloc.add(GetPsp(widget.product.id));
    }
    selectIndex = !widget.isDiscount
        ? widget.selectIndex ?? 0
        : widget.product.prices.first.discount;
    dataIndex = widget.dataIndex ?? -1;
    mydate = widget.mydate ?? DateTime.now();
    if (widget.product.prices.isNotEmpty) {
      pricePercent =
          ((widget.product.prices[0].discountPrice / 100) * selectIndex)
              .toInt();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoodsBloc, GoodsState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return SizedBox(
          width: 600,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.psp.isNotEmpty || state.status2.isInProgress)
                  PspViewer(
                    dataIndex: widget.dataIndex,
                    bloc: widget.bloc,
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
                  ),
                Center(
                  child: WButton(
                    width: 200,
                    margin: const EdgeInsets.only(top: 16),
                    onTap: () {
                      if (widget.isCart) {
                        widget.cartBloc.add(
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
                            discountPrice: selectIndex,
                            selectIndex: selectIndex,
                            dataIndex: dataIndex,
                            pricePercent: pricePercent,
                          ),
                        );
                      } else {
                        widget.cartBloc.add(
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
                            discountPrice: selectIndex,
                            selectIndex: selectIndex,
                            dataIndex: dataIndex,
                            pricePercent: pricePercent,
                          ),
                        );
                      }
                      Navigator.pop(context);
                    },
                    text: 'specialist_category'.tr(),
                    isDisabled: !widget.isProduct &&
                            !selction &&
                            widget.selectIndex != null
                        ? selectIndex == widget.selectIndex
                        : false,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
