import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/accounts_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/add_user_iteam.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/create_ph_jsh.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

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
                    context.read<AccountsBloc>().add(PostPhone(
                          phoneJshshr: vm.phone.text,
                          onSuccess: (exodim) {
                            if (exodim.id != 0) {
                              url = exodim.photo;
                              vm.selectAccount(
                                AccountsEntity(
                                  name: exodim.firstName,
                                  lastname: exodim.lastName,
                                  surname: exodim.middleName,
                                  education: exodim.education,
                                  pinfl: vm.phone.text,
                                  phone: exodim.phone,
                                  gender: exodim.sex,
                                  birthday: exodim.birthday,
                                  birthPlace: exodim.birthPlace,
                                  nationality: exodim.nationality,
                                  currentPlace: exodim.currentPlace,
                                  position: exodim.positions
                                      .map((e) => e.position)
                                      .toList()
                                      .join(", "),
                                  isAfgan: exodim.comment.afghan != "-",
                                  isCherno: exodim.comment.chernobyl != "-",
                                  isInvalid: exodim.comment.invalid != "-",
                                  isUvu: exodim.comment.railwayTitle != "-",
                                ),
                                true,
                              );
                              setState(() {});
                            } else {
                              setState(() {
                                vm.isChek = true;
                                vm.isCreat = true;
                              });
                            }
                          },
                          onError: (error) {
                            context.read<AccountsBloc>().add(AccountsGet(
                                  search: vm.phone.text.contains("+")
                                      ? vm.phone.text.substring(1)
                                      : vm.phone.text,
                                  onSucces: (account) {
                                    context
                                        .read<AccountsBloc>()
                                        .add(GetCupon(user: account.username));
                                    Log.d(account);

                                    Log.d(account.name);
                                    vm.selectAccount(account, false);

                                    context
                                        .read<MyNavigatorBloc>()
                                        .add(NavId(1));
                                  },
                                  onError: () {
                                    context.read<ShowPopUpBloc>().add(
                                          ShowPopUp(
                                            message: widget.vm.phone.text
                                                    .startsWith("+")
                                                ? LocaleKeys.number_has_user
                                                    .tr()
                                                : LocaleKeys.user_this_PINFL
                                                    .tr(),
                                            status: PopStatus.error,
                                          ),
                                        );
                                  },
                                ));
                          },
                        ));
                  },
                ),
                if (vm.isChek)
                  AddUsetIteam(
                    vm: vm,
                    isNew: true,
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
