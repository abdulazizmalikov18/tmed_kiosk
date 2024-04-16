import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/features/common/ticket/recept_roll_80.dart';
import 'package:tmed_kiosk/features/common/ticket/tickets/recept_roll_80_avans.dart';
import 'package:tmed_kiosk/features/common/ticket/w_dialog_printer.dart';
import 'package:tmed_kiosk/features/common/widgets/w_tab_bar.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/post_product_filter.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/main/domain/entity/price_entity.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/info_price_row.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
part 'package:tmed_kiosk/features/main/presentation/controllers/chek_price_controller.dart';

class ChekPriceIteam extends StatefulWidget {
  const ChekPriceIteam({
    super.key,
    required this.allPrice,
    required this.discount,
    required this.moneyEntered,
    required this.tabIndex,
    this.avans = 0,
    required this.list,
    this.isOrder = '',
    required this.vat,
    required this.vmA,
    required this.isDeliveriy,
    required this.vm,
  });
  final int allPrice;
  final int discount;
  final int moneyEntered;
  final TabController tabIndex;
  final int avans;
  final bool isDeliveriy;
  final List<MyPriceEntity> list;
  final AccountsViewModel vmA;
  final String isOrder;
  final int vat;
  final CartViewModel vm;
  @override
  State<ChekPriceIteam> createState() => _ChekPriceIteamState();
}

class _ChekPriceIteamState extends State<ChekPriceIteam>
    with CheckPriceController {
  @override
  Widget build(BuildContext context) {
    final size = MyFunctions.paddingRespons(MediaQuery.sizeOf(context).height);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Container(
          decoration: wdecoration2,
          margin: EdgeInsets.fromLTRB(size, 0, size, size),
          padding: EdgeInsets.all(size),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 36,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        LocaleKeys.cart_price_total.tr(),
                        style: AppTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const Spacer(flex: 1),
                    Expanded(
                      flex: 5,
                      child: SizedBox(
                        height:
                            MediaQuery.sizeOf(context).height > 800 ? 36 : 28,
                        child: WTabBar(
                          padding: EdgeInsets.zero,
                          tabController: widget.tabIndex,
                          onTap: (p0) {
                            setState(() {});
                          },
                          tabs: [
                            Text(LocaleKeys.pay_order_payment_button.tr()),
                            Text(LocaleKeys.pay_order_prepaid_expense.tr()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 24, color: greyText),
              InfoPriceRow(
                name: '${LocaleKeys.pay_total_price_total.tr()}:',
                price: state.discount < 0
                    ? state.allPrice - (state.discount * -1)
                    : state.allPrice,
                type: '',
              ),
              InfoPriceRow(
                name: '${LocaleKeys.pay_total_price_vat.tr()}:',
                price: (widget.allPrice * (widget.vat / 100)).toInt(),
                type: '${widget.vat} %',
              ),
              InfoPriceRow(
                name: '${LocaleKeys.pay_discount.tr()}:',
                price: state.discount,
                type: '',
                isDiscount: true,
              ),
              if (context
                      .read<AccountsBloc>()
                      .state
                      .selectAccount
                      .selectCupon
                      .id !=
                  0)
                InfoPriceRow(
                  name: '${LocaleKeys.adduser_coupon.tr()}:',
                  price: 0,
                  type: '0 %',
                ),
              if (widget.avans != 0)
                InfoPriceRow(
                  name: '${LocaleKeys.pay_order_prepaid_expense.tr()}:',
                  price: widget.avans,
                  type: '',
                ),
              InfoPriceRow(
                name: 'To’lovga:',
                price: state.allPrice - state.avans,
                type: '',
              ),
              InfoPriceRow(
                name: 'Kiritilgan pul:',
                price: widget.moneyEntered,
                type: '',
              ),
              InfoPriceRow(
                name: '${LocaleKeys.pay_total_price_short_change.tr()}:',
                price: widget.moneyEntered - widget.allPrice > 0
                    ? widget.moneyEntered - widget.allPrice
                    : 0,
                type: '',
              ),
              InfoPriceRow(
                name: 'To’lov turi:',
                subName: widget.tabIndex.index == 0
                    ? LocaleKeys.check_payment_button.tr()
                    : LocaleKeys.pay_order_prepaid_expense.tr(),
                type: '',
                price: 0,
              ),
              InfoPriceRow(
                name: '${LocaleKeys.adduser_region.tr()}:',
                subName: widget.isDeliveriy
                    ? LocaleKeys.order_type_delivery.tr()
                    : LocaleKeys.order_type_onplace.tr(),
                type: '',
                price: 0,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: WButton(
                      onTap: () {
                        context.read<MyNavigatorBloc>().add(NavId(0));
                      },
                      text: LocaleKeys.cart_order_cancel_button.tr(),
                      color: red,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: WButton(
                      isLoading: state.status.isInProgress,
                      isDisabled: isDeisebled(state.selStatus.id),
                      onTap: () {
                        checkStatus(state);
                      },
                      text: LocaleKeys.check_payment_button.tr(),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
