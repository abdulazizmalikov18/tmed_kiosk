import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/accounts_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/add_user_iteam.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/create_ph_jsh.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class UserAddView extends StatefulWidget {
  const UserAddView({super.key, required this.vm, required this.vmC});

  final AccountsViewModel vm;
  final CartViewModel vmC;

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
      appBar: AppBar(
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
        // toolbarHeight: 76,
        // actions: [
        //   WButton(
        //     height: 64,
        //     onTap: () {
        //       context.pop();
        //     },
        //     text: "place_an_order".tr(),
        //     textStyle: const TextStyle(
        //       fontSize: 22,
        //       color: white,
        //     ),
        //     color: blue,
        //     padding: const EdgeInsets.symmetric(horizontal: 12),
        //     margin: const EdgeInsets.symmetric(horizontal: 15)
        //         .copyWith(bottom: 18, top: 0),
        //   )
        // ],
      ),
      body: BlocBuilder<AccountsBloc, AccountsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CreatePhJsh(
                  vm: vm,
                  onTap: () {
                    Log.w("Tuzukmi gap");
                    context.read<AccountsBloc>().add(PostPhone(
                      phoneJshshr: vm.phone.text,
                      onSuccess: (exodim) {
                        if (exodim.id != 0) {
                          final name = exodim.name.split(' ');
                          url = exodim.photo;
                          vm.selectAccount(
                            AccountsEntity(
                              name: exodim.name.isNotEmpty
                                  ? name[1]
                                  : "",
                              lastname: name.last,
                              surname: name.first,
                              education: exodim.education,
                              pinfl: vm.phone.text,
                              phone: exodim.phone,
                              birthPlace: exodim.birthPlace,
                              nationality: exodim.nationality,
                              currentPlace: exodim.currentPlace,
                            ),
                            true,
                          );
                          setState(() {});
                        } else {
                          setState(() {
                            vm.isChek = true;
                          });
                        }
                      },
                      onError: (error) {
                        Log.w("NIma gap");
                        context
                            .read<AccountsBloc>()
                            .add(AccountsGet(
                          search: vm.phone.text,
                          onSucces: (account) {
                            context.read<AccountsBloc>().add(
                                GetCupon(
                                    user: account.username));
                            vm.selectAccount(account, true);
                            Navigator.of(context).pop();
                            context.read<AccountsBloc>().add(
                                IsFocused(isFocused: false));
                          },
                          onError: () {
                            context.read<ShowPopUpBloc>().add(
                              ShowPopUp(
                                message: widget
                                    .vm.phone.text
                                    .startsWith("+")
                                    ? LocaleKeys
                                    .number_has_user
                                    .tr()
                                    : LocaleKeys
                                    .user_this_PINFL
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
                    isChanged: vm.name.text.isNotEmpty,
                    url: url,
                    vmC: widget.vmC,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
