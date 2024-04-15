import 'package:tmed_kiosk/features/cart/presentation/widgets/cupon/cupon_iteam.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/mixin/cart_mixin.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/cart_item_noprice.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/order_status_selection.dart';
import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/cart_list_iteam.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/info_price_row.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/no_data_cart.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class CardListIteam extends StatefulWidget {
  const CardListIteam({super.key, required this.vm, required this.vmA});
  final CartViewModel vm;
  final AccountsViewModel vmA;

  @override
  State<CardListIteam> createState() => _CardListIteamState();
}

class _CardListIteamState extends State<CardListIteam> with CartMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceBloc, PriceState>(
      builder: (context, statePrice) {
        return BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return BlocBuilder<AccountsBloc, AccountsState>(
              builder: (context, stateAccount) {
                if (state.cartMap.isNotEmpty) {
                  if (statePrice.isPrice) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: state.cartMap.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) => CartListIteam(
                                  vm: vm,
                                  index: index,
                                  product: state.cartMap[
                                      (state.cartMap.keys).toList()[index]]!,
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                              ),
                            ),
                          ),
                        ),
                        state.isOrder.isEmpty
                            ? CuponIteam(vm: vm)
                            : const SizedBox(),
                        Container(
                          decoration: wdecoration2,
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.cartPriceTotal.tr(),
                                style: AppTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const Divider(height: 24, color: greyText),
                              InfoPriceRow(
                                name: '${LocaleKeys.payTotalPriceTotal.tr()}:',
                                price: state.discount < 0
                                    ? state.allPrice - (state.discount * -1)
                                    : state.allPrice,
                                type: '',
                              ),
                              InfoPriceRow(
                                name: 'Chegirma/Ustama:',
                                price: state.discount,
                                type: '',
                                isDiscount: true,
                              ),
                              // InfoPriceRow(
                              //   name: '${LocaleKeys.payTotalPriceVat.tr()}:',
                              //   price: (state.allPrice *
                              //           (state
                              //                   .cartMap[(state.cartMap.keys)
                              //                       .toList()[0]]
                              //                   ?.vat ??
                              //               0 / 100))
                              //       .toInt(),
                              //   type:
                              //       "${state.cartMap[(state.cartMap.keys).toList()[0]]?.vat ?? 0} %",
                              // ),

                              if (stateAccount.selectAccount.selectCupon.id !=
                                  0)
                                InfoPriceRow(
                                  name: "Kupon:",
                                  price: 0,
                                  type:
                                      '${state.cupon.productDiscount.toInt()} %',
                                ),
                              InfoPriceRow(
                                name: 'To’lovga:',
                                price: state.allPrice - state.avans,
                                type: '',
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: WButton(
                                      onTap: () {
                                        widget.vmA.clearAccount(context);
                                        context
                                            .read<CartBloc>()
                                            .add(CartRemove());
                                      },
                                      text:
                                          LocaleKeys.cartOrderCancelButton.tr(),
                                      color: red,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: WButton(
                                      onTap: () {
                                        checkUser(
                                          cartMap: state.cartMap,
                                          selUsername: stateAccount
                                              .selectAccount
                                              .selectAccount
                                              .username,
                                          username: state.username,
                                        );
                                      },
                                      text: LocaleKeys.checkPaymentButton.tr(),
                                      isLoading: state.status.isInProgress,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: state.cartMap.length,
                                itemBuilder: (context, index) =>
                                    CartListIteamNoPrice(
                                  vm: vm,
                                  index: index,
                                  product: state.cartMap[
                                      (state.cartMap.keys).toList()[index]]!,
                                  counts: state.counts,
                                  allPrice: state.allPrice,
                                  discount: state.discount,
                                  bloc: context.read<GoodsBloc>(),
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          OrderStatusSelection(state: state),
                          // const SizedBox(height: 16),
                          // TaskComment(
                          //   vm: vm,
                          //   comment: state.orders.clientComment,
                          // ),
                          const SizedBox(height: 16),
                          Container(
                            decoration: wdecoration2,
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Vazifaga izoh",
                                  style: AppTheme.bodyLarge,
                                ),
                                const Divider(height: 24),
                                WButton(
                                  onTap: () {
                                    context
                                        .read<MyNavigatorBloc>()
                                        .add(NavId(5));
                                  },
                                  color: blue,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AppIcons.addCircle.svg(),
                                      const SizedBox(width: 8),
                                      const Text("Izoh qo‘shish"),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: WButton(
                                        onTap: () {
                                          widget.vmA.clearAccount(context);
                                          context
                                              .read<CartBloc>()
                                              .add(CartRemove());
                                          vm.controllerComment.clear();
                                          vm.task.clear();
                                        },
                                        text: LocaleKeys.cartOrderCancelButton
                                            .tr(),
                                        color: red,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: WButton(
                                        onTap: () {
                                          context
                                              .read<MyNavigatorBloc>()
                                              .add(NavId(2));
                                        },
                                        text: "Vazifa berish",
                                        color: green,
                                        isLoading: state.status.isInProgress,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                } else {
                  return const Center(child: NoDataCart());
                }
              },
            );
          },
        );
      },
    );
  }
}
