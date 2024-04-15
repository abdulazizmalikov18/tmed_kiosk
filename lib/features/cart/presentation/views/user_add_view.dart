import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/add_user_iteam.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/create_ph_jsh.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';

class UserAddView extends StatefulWidget {
  const UserAddView({super.key, required this.vm});
  final AccountsViewModel vm;

  @override
  State<UserAddView> createState() => _UserAddViewState();
}

class _UserAddViewState extends State<UserAddView> {
  late final vm = widget.vm;
  String first = '';

  @override
  void initState() {
    context.read<AccountsBloc>().add(GetRegion());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CreatePhJsh(
                vm: vm,
                onTap: () {
                  context.read<AccountsBloc>().add(PostPhone(
                        phoneJshshr: vm.phone.text,
                        onSuccess: () {
                          setState(() {
                            vm.isChek = !vm.isChek;
                          });
                        },
                        onError: (error) {
                          context.read<ShowPopUpBloc>().add(
                                ShowPopUp(
                                  message: widget.vm.phone.text.startsWith("+")
                                      ? "Ushbu raqamda user mavjud"
                                      : "Ushbu  PINFL bilan user mavjud",
                                  status: PopStatus.error,
                                ),
                              );
                        },
                      ));
                },
              ),
              if (vm.isChek) AddUsetIteam(vm: vm, isNew: true),
            ],
          ),
        );
      },
    );
  }
}
