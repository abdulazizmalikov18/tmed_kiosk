import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/accounts_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/add_user_iteam.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/create_ph_jsh.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/navigation/routs_contact.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';

class UserAddView extends StatefulWidget {
  const UserAddView({super.key, required this.vm});
  final AccountsViewModel vm;

  @override
  State<UserAddView> createState() => _UserAddViewState();
}

class _UserAddViewState extends State<UserAddView> {
  late final vm = widget.vm;
  String first = '';
  String url = '';
  File? images;

  @override
  void initState() {
    context.read<AccountsBloc>().add(GetRegion());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AccountsBloc, AccountsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CreatePhJsh(
                  vm: vm,
                  onTap: () {
                    context.read<AccountsBloc>().add(
                          PostPhone(
                            phoneJshshr: vm.phone.text,
                            onSuccess: (exodim) {
                              final name = exodim.name.split(' ');
                              url = exodim.photo;
                              widget.vm.selectAccount(AccountsEntity(
                                name: name.first,
                                lastname: name.last,
                                phone: vm.phone.text,
                              ));
                              setState(() {});
                            },
                            onError: (error) {
                              Log.w("Nima gap");
                              context.read<AccountsBloc>().add(AccountsGet(
                                    search: vm.phone.text,
                                    onSucces: () {
                                      widget.vm.selectAccount(
                                          state.selectAccount.selectAccount);
                                      context.read<AccountsBloc>().add(GetCupon(
                                          user: state.selectAccount
                                              .selectAccount.username));

                                      context.pop();
                                      context.push(RoutsContact.userInfo,
                                          extra: widget.vm);
                                    },
                                    onError: () {
                                      context.read<ShowPopUpBloc>().add(
                                          ShowPopUp(
                                              message: "User Topilmadi",
                                              status: PopStatus.error));
                                    },
                                  ));
                            },
                          ),
                        );
                  },
                ),
                if (vm.isChek)
                  AddUsetIteam(
                    vm: vm,
                    isNew: true,
                    file: images,
                    url: url,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
