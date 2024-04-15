import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/card_list_iteam.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/cart_pay_view.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/history_view.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/task_create_view.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/user_add_view.dart';
import 'package:tmed_kiosk/features/cart/presentation/views/user_info_view.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/accounts_list.dart';
import 'package:tmed_kiosk/features/common/widgets/cart_appbar.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VCartItem extends StatefulWidget {
  const VCartItem({super.key});

  @override
  State<VCartItem> createState() => _VCartItemState();
}

class _VCartItemState extends State<VCartItem> {
  late final vmA = AccountsViewModel();
  late final vmC = CartViewModel();
  bool cartClose = false;

  List<Widget> page = [];

  @override
  void initState() {
    page = [
      CardListIteam(vm: vmC, vmA: vmA),
      UserInfoView(vm: vmA),
      CartPayView(vm: vmC, vmA: vmA),
      HistoryView(vm: vmA),
      UserAddView(vm: vmA),
      TaskCreateView(vm: vmC),
      AccountsList(vm: vmA)
    ];
    context.read<AccountsBloc>().add(AccountsGet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyNavigatorBloc, MyNavigatorState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              state.navid != 2 ? CartAppBar(vm: vmA) : const SizedBox(),
              Expanded(child: page[state.navid]),
            ],
          ),
        );
      },
    );
  }
}
