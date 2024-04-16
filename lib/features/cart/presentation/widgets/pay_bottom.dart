import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/post_product_filter.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/main/domain/entity/price_entity.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class PayButton extends StatefulWidget {
  const PayButton({
    super.key,
    required this.list,
    required this.isOrder,
    required this.id,
    required this.isAllPrice,
  });
  final List<MyPriceEntity> list;
  final bool isOrder;
  final String id;
  final bool isAllPrice;

  @override
  State<PayButton> createState() => _PayButtonState();
}

class _PayButtonState extends State<PayButton> {
  bool isAvans = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
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
                    setState(() {
                      isAvans = true;
                    });
                    List<Map<String, dynamic>> nimadir = [];
                    for (var i = 1; i < widget.list.length; i++) {
                      if (widget.list[i].controller.text.isNotEmpty) {
                        nimadir.add({
                          "method": widget.list[i].method,
                          "cost": widget.list[i].controller.text
                        });
                      }
                    }
                    context.read<CartBloc>().add(
                          CreatOrder(
                            onError: (nima) {
                              context.read<ShowPopUpBloc>().add(ShowPopUp(
                                  message: nima, status: PopStatus.error));
                            },
                            onSuccess: (data) {
                              Navigator.of(context)
                                ..pop()
                                ..pop();
                              context.read<ShowPopUpBloc>().add(ShowPopUp(
                                    message: MyFunctions.createPrice(context),
                                    status: PopStatus.success,
                                  ));
                            },
                            filter: PostProductFilter(
                              paymentinorderSet: nimadir,
                              clientComment: widget.list[0].controller.text,
                            ),
                          ),
                        );
                  },
                  text: LocaleKeys.pay_order_prepaid_expense.tr(),
                  color: green,
                  isLoading: state.status.isInProgress && isAvans,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: WButton(
                  isDisabled: !widget.isAllPrice,
                  isLoading: state.status.isInProgress && !isAvans,
                  onTap: () {
                    setState(() {
                      isAvans = false;
                    });
                    List<Map<String, dynamic>> nimadir = [];
                    for (var i = 1; i < widget.list.length; i++) {
                      if (widget.list[i].controller.text.isNotEmpty) {
                        nimadir.add({
                          "method": widget.list[i].method,
                          "cost": widget.list[i].controller.text
                        });
                      }
                    }
                    final remote =
                        context.read<AccountsBloc>().state.selectAccount;
                    context.read<CartBloc>().add(
                          CreatOrder(
                            username: remote.selectAccount.username.isNotEmpty
                                ? remote.selectAccount.username
                                : null,
                            onSuccess: (data) {
                              Navigator.of(context)
                                ..pop()
                                ..pop();

                              context.read<ShowPopUpBloc>().add(ShowPopUp(
                                    message: MyFunctions.createPrice(context),
                                    status: PopStatus.success,
                                  ));
                            },
                            onError: (p0) {
                              context.read<ShowPopUpBloc>().add(ShowPopUp(
                                    message: p0,
                                    status: PopStatus.error,
                                  ));
                            },
                            filter: PostProductFilter(
                              method: true,
                              paymentinorderSet: nimadir,
                              clientComment: widget.list[0].controller.text,
                            ),
                          ),
                        );
                  },
                  text: LocaleKeys.check_payment_button.tr(),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
