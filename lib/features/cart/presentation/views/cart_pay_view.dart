import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/order_status_selection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';
import 'package:tmed_kiosk/features/main/domain/entity/price_entity.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/chek_price_iteam.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/pay_add_list.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/w_row_input.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class CartPayView extends StatefulWidget {
  const CartPayView({super.key, required this.vm, required this.vmA});
  final CartViewModel vm;
  final AccountsViewModel vmA;

  @override
  State<CartPayView> createState() => _CartPayViewState();
}

class _CartPayViewState extends State<CartPayView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<MyPriceEntity> list = [
    MyPriceEntity(
      controller: TextEditingController(),
      name: LocaleKeys.pay_order_name.tr(),
      method: 1,
    ),
    MyPriceEntity(
      controller: TextEditingController(),
      name: LocaleKeys.pay_order_cash.tr(),
      method: 1,
    ),
    MyPriceEntity(
      controller: TextEditingController(),
      name: LocaleKeys.pay_order_humo.tr(),
      image: AppImages.humo,
      method: 7,
    ),
    MyPriceEntity(
      controller: TextEditingController(),
      name: LocaleKeys.pay_order_uzcard.tr(),
      image: AppImages.uzcard,
      method: 8,
    ),
  ];
  List<MyPriceEntity> list2 = [
    MyPriceEntity(
      controller: TextEditingController(),
      name: LocaleKeys.pay_order_transfer.tr(),
      method: 6,
    ),
    MyPriceEntity(
      controller: TextEditingController(),
      name: LocaleKeys.pay_order_cashback.tr(),
      method: 5,
    ),
    MyPriceEntity(
      controller: TextEditingController(),
      name: LocaleKeys.pay_order_anor.tr(),
      image: AppImages.anorbank,
      method: 11,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: contColor,
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.check_payment_button.tr()),
                    Text(
                      "${context.read<AccountsBloc>().state.selectAccount.selectAccount.name} ${context.read<AccountsBloc>().state.selectAccount.selectAccount.lastname}",
                      style: AppTheme.labelSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.vm.closePay();
                  context.read<MyNavigatorBloc>().add(NavId(0));
                },
                icon: AppIcons.closeCircle.svg(),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...List.generate(
                            list.length,
                            (index) => WRowInput(
                              keyboardType: TextInputType.text,
                              controller: list[index].controller,
                              image: list[index].image != null,
                              imNm: list[index].image ?? list[index].name,
                              isnum: index != 0,
                              onChanged: (p0) {
                                widget.vm
                                    .checkPrice(list, state.allPrice, index);
                                setState(() {});
                              },
                              onTap: () {
                                widget.vm.textPrice(
                                  list,
                                  state.allPrice,
                                  index,
                                  state.avans,
                                );
                                setState(() {});
                              },
                              onTapClose: () {
                                list[index].controller.text = '';
                                widget.vm
                                    .checkPrice(list, state.allPrice, index);
                                setState(() {});
                              },
                            ),
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    GridView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16,
                                        mainAxisExtent: 48,
                                      ),
                                      shrinkWrap: true,
                                      itemCount: list2.length,
                                      itemBuilder: (context, index) =>
                                          WScaleAnimation(
                                        onTap: () {
                                          setState(() {
                                            list.add(list2[index]);
                                            list2.removeAt(index);
                                          });
                                        },
                                        child: PayAddList(entity: list2[index]),
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
                  if (state.isOrder.isEmpty)
                    Padding(
                      padding: EdgeInsets.all(MyFunctions.paddingRespons(
                          MediaQuery.sizeOf(context).height)),
                      child: const OrderStatusSelection(),
                    ),
                  ChekPriceIteam(
                    allPrice: state.allPrice,
                    discount: state.discount,
                    moneyEntered: widget.vm.moneyEntered,
                    tabIndex: _tabController,
                    isDeliveriy: widget.vm.isDeliveriy,
                    avans: state.avans,
                    list: list,
                    vmA: widget.vmA,
                    isOrder: state.isOrder,
                    vm: widget.vm,
                    vat: state.cartMap.isNotEmpty
                        ? state.cartMap[(state.cartMap.keys).toList().first]
                                ?.vat ??
                            0
                        : 0,
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
