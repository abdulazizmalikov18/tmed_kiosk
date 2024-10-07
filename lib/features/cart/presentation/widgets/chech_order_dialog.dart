import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/accounts_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/entity/orders_entity.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:tmed_kiosk/features/common/ticket/recept_roll_80.dart';
import 'package:tmed_kiosk/features/common/ticket/w_dialog_printer.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/main.dart';

class ChechOrderDialog extends StatefulWidget {
  const ChechOrderDialog({
    super.key,
    required this.bloc,
    required this.tashkilot,
    required this.orders,
    required this.blocAccount,
    required this.blocNavigator,
  });

  final CartBloc bloc;
  final AccountsBloc blocAccount;
  final MyNavigatorBloc blocNavigator;
  final String tashkilot;
  final OrdersEntity orders;

  @override
  State<ChechOrderDialog> createState() => _ChechOrderDialogState();
}

class _ChechOrderDialogState extends State<ChechOrderDialog> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 460,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: AppIcons.closeCircle.svg(),
            ),
          ),
          SizedBox(
            height: 200,
            child: Lottie.asset(
              $appType.logoImage,
              alignment: Alignment.bottomCenter,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "this_customer_new_order".tr(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: context.color.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          WButton(
            onTap: () {
              Navigator.of(context).pop();
              widget.bloc.add(CartAddOrder(
                orders: widget.orders,
                onSuccess: () {
                  if (widget.orders.user.username.isNotEmpty) {
                    widget.blocAccount.add(AccountsUsernameEvent(
                      username: widget.orders.user.username,
                      onSucces: () {},
                      onError: () {
                        widget.blocAccount.add(SelectionAccount(
                          account: AccountsEntity(
                            id: 1,
                            avatar: [widget.orders.user.avatar],
                            name: widget.orders.user.name,
                            lastname: widget.orders.user.lastname,
                            birthday: widget.orders.user.birthdate,
                            gender: widget.orders.user.gender,
                            username: widget.orders.user.username,
                          ),
                        ));
                      },
                    ));

                    widget.blocAccount
                        .add(GetCupon(user: widget.orders.user.username));
                  }
                },
                onError: (p0) {
                  context.read<ShowPopUpBloc>().add(ShowPopUp(
                      message: "no_job_information".tr(),
                      status: PopStatus.error));
                },
              ));
              widget.blocNavigator.add(NavId(0));
              if (Platform.isAndroid || Platform.isIOS) {
                Navigator.of(context)
                  ..pop()
                  ..pop();
              }
            },
            height: 48,
            text: "working_with_order".tr(),
          ),
          const SizedBox(height: 16),
          WButton(
            onTap: () async {
              try {
                final dataPrint = await ReceiptRoll80(
                  data: widget.orders,
                  vat: 12,
                  tashkilot: widget.tashkilot,
                ).show();
                showDialog(
                  context: context,
                  builder: (context) => PrinterDialog(data: dataPrint),
                );
              } catch (e) {
                Log.e(e);
              }
            },
            height: 48,
            color: Colors.transparent,
            border: Border.all(color: blue),
            textColor: context.color.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIcons.printer.svg(color: greyText),
                const SizedBox(width: 12),
                Text(
                  "print_order".tr(),
                  style: TextStyle(color: context.color.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          WButton(
            onTap: () {
              Navigator.of(context).pop();
              widget.blocNavigator.add(NavId(0));
              if (Platform.isAndroid || Platform.isIOS) {
                Navigator.of(context)
                  ..pop()
                  ..pop();
              }
            },
            color: green,
            height: 48,
            textColor: context.color.white,
            text: "create_new_order".tr(),
          )
        ],
      ),
    );
  }
}
