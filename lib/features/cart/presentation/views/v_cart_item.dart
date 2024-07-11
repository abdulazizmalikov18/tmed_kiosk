import 'package:go_router/go_router.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/user_set/selection_account.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/card_list_iteam.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VCartItem extends StatefulWidget {
  const VCartItem({super.key, required this.isAccount});

  final bool isAccount;

  @override
  State<VCartItem> createState() => _VCartItemState();
}

class _VCartItemState extends State<VCartItem> {
  late final vmA = AccountsViewModel();
  late final vmC = CartViewModel();
  bool cartClose = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyNavigatorBloc, MyNavigatorState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.color.contColor,
          appBar: state.navid != 2
              ? AppBar(
                  backgroundColor: context.color.backGroundColor,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15)
                        .copyWith(bottom: 18, top: 0),
                    child: IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: context.color.white,
                        size: 32,
                      ),
                    ),
                  ),
                  title: BlocSelector<AccountsBloc, AccountsState,
                      SelectionAccountEntity>(
                    builder: (context, state) {
                      return Text(
                        "${state.selectAccount.name} ${state.selectAccount.lastname}",
                        style: AppTheme.displaySmall
                            .copyWith(color: context.color.white),
                      );
                    },
                    selector: (state) => state.selectAccount,
                  ),
                )
              : null,
          body: CardListIteam(
            vm: vmC,
            vmA: vmA,
            isAccount: widget.isAccount,
          ),
        );
      },
    );
  }
}
