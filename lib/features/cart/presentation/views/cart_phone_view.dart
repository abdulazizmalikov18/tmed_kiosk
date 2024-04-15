import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/post_product_filter.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/add_user_phone.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/cart_item_noprice.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/task_create_view.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/create_order_bottom.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/order_status_selection.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/w_info_price.dart';
import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/list_count.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/cart_pay_phone.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/cupon/cupon_iteam.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/navigation/presentation/navigator.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/cart_list_iteam_phone.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/no_data_cart.dart';
import 'package:formz/formz.dart';

part 'package:tmed_kiosk/features/cart/presentation/controllers/controllers.dart';

class CartPhoneView extends StatefulWidget {
  const CartPhoneView({super.key, required this.vm});
  final AccountsViewModel vm;

  @override
  State<CartPhoneView> createState() => _CartPhoneViewState();
}

class _CartPhoneViewState extends State<CartPhoneView> with CartPhoneMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text('Vazifa'),
            actions: [
              BlocBuilder<AccountsBloc, AccountsState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      if (state.selectAccount.selectAccount.id != 0) {
                        widget.vm
                            .selectAccount(state.selectAccount.selectAccount);
                      }
                      Navigator.of(context).push(
                        fade(page: AddUserPhone(vm: widget.vm, vmC: vm)),
                      );
                    },
                    icon: state.selectAccount.selectAccount.id != 0
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(44),
                            child: Image.network(
                              state.selectAccount.selectAccount.avatar
                                      .isNotEmpty
                                  ? state.selectAccount.selectAccount.avatar[0]
                                  : '',
                              fit: BoxFit.cover,
                              errorBuilder: (context, url, error) =>
                                  Image.asset(AppImages.user),
                            ),
                          )
                        : AppIcons.userAdd.svg(
                            color: white50,
                            height: 20,
                            width: 20,
                          ),
                  );
                },
              ),
              if (state.cartMap.isNotEmpty)
                IconButton(
                  onPressed: () {
                    widget.vm.clearAccount(context);
                    context.read<CartBloc>().add(CartRemove());
                  },
                  icon: AppIcons.delate.svg(),
                ),
              const SizedBox(width: 4),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (state.cartMap.isNotEmpty) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        itemCount: state.cartMap.length,
                        itemBuilder: (context, index) {
                          if (isPrice) {
                            return CartListIteamPhone(
                              index: index,
                              product: state.cartMap[
                                  (state.cartMap.keys).toList()[index]]!,
                              vm: vm,
                            );
                          } else {
                            return CartListIteamNoPrice(
                              vm: vm,
                              index: index,
                              bloc: context.read<GoodsBloc>(),
                              product: state.cartMap[
                                  (state.cartMap.keys).toList()[index]]!,
                              counts: state.counts,
                              allPrice: state.allPrice,
                              discount: state.discount,
                            );
                          }
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        if (isPrice) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              WInfoPrice(
                                allPrice: state.allPrice,
                                discount: state.discount,
                                vat: state
                                        .cartMap[
                                            (state.cartMap.keys).toList()[0]]
                                        ?.vat ??
                                    0,
                              ),
                              CuponIteam(vm: vm),
                            ],
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                OrderStatusSelection(state: state),
                                const SizedBox(height: 16),
                                WButton(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(CupertinoDialogRoute(
                                      builder: (context) =>
                                          TaskCreateView(vm: vm, isPhone: true),
                                      context: context,
                                    ));
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
                              ],
                            ),
                          );
                        }
                      },
                    )
                  ],
                );
              } else {
                return const Center(child: NoDataCart());
              }
            },
          ),
          bottomNavigationBar: state.cartMap.isNotEmpty
              ? BlocBuilder<AccountsBloc, AccountsState>(
                  builder: (context, stateAccount) {
                    if (isPrice) {
                      return CreateOrderBottom(
                        onTapLeft: () {
                          createOrders(stateAccount);
                        },
                        onTapRight: () {
                          Navigator.of(context)
                              .push(fade(page: CartPayPhone(vm: vm)));
                        },
                        status: state.status,
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                        decoration: BoxDecoration(
                          color: contColor,
                          boxShadow: wboxShadow,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: WButton(
                                onTap: () {
                                  widget.vm.clearAccount(context);
                                  context.read<CartBloc>().add(CartRemove());
                                  vm.controllerComment.clear();
                                  Navigator.of(context).pop();
                                },
                                text: LocaleKeys.cartOrderCancelButton.tr(),
                                color: red,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: WButton(
                                onTap: () {
                                  createOrder(
                                    cartMap: state.cartMap,
                                    counts: state.counts,
                                    isOrder: state.isOrder,
                                    selUsername: stateAccount
                                        .selectAccount.selectAccount.username,
                                    username: state.username,
                                  );
                                },
                                text: "Vazifa berish",
                                color: green,
                                isLoading: state.status.isInProgress,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                )
              : null,
        );
      },
    );
  }
}
