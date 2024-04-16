import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/search_accounts.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key, required this.vm});
  final AccountsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return BlocBuilder<MyNavigatorBloc, MyNavigatorState>(
          builder: (context, stateN) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back_outlined),
                  ),
                  const SizedBox(width: 16),
                  SearchAccount(vm: vm),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      if (stateN.navid == 1 || stateN.navid == 4) {
                        context.read<MyNavigatorBloc>().add(NavId(0));
                      } else {
                        if (state
                            .selectAccount.selectAccount.username.isEmpty) {
                          context.read<MyNavigatorBloc>().add(NavId(4));
                        } else {
                          vm.selectAccount(state.selectAccount.selectAccount);
                          context.read<MyNavigatorBloc>().add(NavId(1));
                        }
                      }
                    },
                    icon: AppIcons.userAdd.svg(
                      color: stateN.navid == 1 ||
                              stateN.navid == 4 ||
                              state.selectAccount.selectAccount.name.isNotEmpty
                          ? context.color.white
                          : white50,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
