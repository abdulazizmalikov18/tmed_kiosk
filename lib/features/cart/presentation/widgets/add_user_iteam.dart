import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/core/utils/formatters.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/cupon_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/profession_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/region_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/user_camera_macos.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/cupon/cupon_dialog.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/gender_drop_down.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/profession/profession_dalog.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/region/region_dialog.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/user_camera.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

part 'package:tmed_kiosk/features/cart/presentation/controllers/add_user_contoller.dart';

class AddUsetIteam extends StatefulWidget {
  const AddUsetIteam({super.key, required this.vm, this.isNew = false});
  final AccountsViewModel vm;
  final bool isNew;

  @override
  State<AddUsetIteam> createState() => _AddUsetIteamState();
}

class _AddUsetIteamState extends State<AddUsetIteam> with AddUserViweModel {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!widget.isNew)
                WButton(
                  onTap: () {},
                  width: 240,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  text: state.selectAccount.selectAccount.phone.isNotEmpty
                      ? "+${state.selectAccount.selectAccount.phone}"
                      : "PNFL ${state.selectAccount.selectAccount.pinfl}",
                  // text: state.selectAccount.selectAccount.status != 2
                  //     ? state.selectAccount.selectAccount.phone.isNotEmpty
                  //         ? "+${state.selectAccount.selectAccount.phone}"
                  //         : "PNFL ${state.selectAccount.selectAccount.pinfl}"
                  //     : "##########${state.selectAccount.selectAccount.phone.substring(state.selectAccount.selectAccount.phone.length - 2)}",
                ),
              const SizedBox(height: 16),
              Column(
                children: [
                  WTextField(
                    height: 56,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      widget.vm.name.value = TextEditingValue(
                        text: Formatters.capitalize(value),
                        selection: widget.vm.name.selection,
                      );
                      changeInfo();
                    },
                    inputFormatters: [Formatters.lotinFormat],
                    enabled: state.selectAccount.selectAccount.status != 2,
                    hintText: "${LocaleKeys.adduser_firstname.tr()}*",
                    controller: widget.vm.name,
                    fillColor: context.color.whiteBlack,
                    style: TextStyle(color: context.color.white),
                  ),
                  const SizedBox(height: 16),
                  WTextField(
                    height: 56,
                    enabled: state.selectAccount.selectAccount.status != 2,
                    onChanged: (value) {
                      widget.vm.latname.value = TextEditingValue(
                        text: Formatters.capitalize(value),
                        selection: widget.vm.latname.selection,
                      );
                      changeInfo();
                    },
                    inputFormatters: [Formatters.lotinFormat],
                    hintText: "${LocaleKeys.adduser_lastname.tr()}*",
                    textCapitalization: TextCapitalization.words,
                    controller: widget.vm.latname,
                    fillColor: context.color.whiteBlack,
                    style: TextStyle(color: context.color.white),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Form(
                      key: _dateFormKey,
                      child: Focus(
                        onFocusChange: (value) {
                          if (!value) {
                            _dateFormKey.currentState!.validate();
                          }
                        },
                        child: WTextField(
                          height: 56,
                          enabled:
                              state.selectAccount.selectAccount.status != 2,
                          onTap: () {
                            _selectDate(context);
                          },
                          inputFormatters: [Formatters.dateFormatter],
                          onChanged: (value) {
                            changeInfo();
                            if (value.length == 10) {
                              _dateFormKey.currentState!.validate();
                            }
                          },
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              if (parseDate(value) != null) {
                                Log.w(parseDate(value));
                                return null;
                              } else {
                                Log.e("NImagp");
                                return "No DateTIme";
                              }
                            } else {
                              return null;
                            }
                          },
                          hintText: "${LocaleKeys.age.tr()}*",
                          controller: widget.vm.age,
                          keyboardType: TextInputType.datetime,
                          fillColor: context.color.whiteBlack,
                          style: TextStyle(color: context.color.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 48,
                    child: GenderDropDown(
                      controller: widget.vm.gender,
                      onChange: () {
                        changeInfo();
                      },
                      isDisebled: state.selectAccount.selectAccount.status == 2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: WButton(
                          onTap: () {
                            context.read<MyNavigatorBloc>().add(NavId(0));
                            widget.vm.clearAccount(context);
                          },
                          color: red,
                          isDisabled:
                              context.read<CartBloc>().state.isOrder.isNotEmpty,
                          text: LocaleKeys.cart_order_cancel_button.tr(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (!widget.isNew) ...[
                        Expanded(
                          child: WButton(
                            onTap: () {
                              context.read<MyNavigatorBloc>().add(NavId(0));
                            },
                            color: green,
                            text: LocaleKeys.adduser_move_to_order.tr(),
                          ),
                        ),
                        if (state.selectAccount.selectAccount.status != 2)
                          const SizedBox(width: 16),
                      ],
                      if (state.selectAccount.selectAccount.status != 2)
                        Expanded(
                          child: WButton(
                            isLoading: state.status.isInProgress,
                            isDisabled: !isChanged,
                            onTap: () {
                              if (widget.vm.isCreat) {
                                if (_dateFormKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Processing Data'),
                                    ),
                                  );
                                }
                              } else {
                                if (_dateFormKey.currentState!.validate()) {
                                  createUser();
                                }
                              }
                            },
                            text: LocaleKeys.adduser_save.tr(),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
