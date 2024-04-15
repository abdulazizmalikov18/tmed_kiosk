import 'dart:io';

import 'package:dio/dio.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
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
              GestureDetector(
                onTap: state.selectAccount.selectAccount.status != 5
                    ? () {
                        getSelectionImage();
                        changeInfo();
                      }
                    : () {},
                child: images == null
                    ? Container(
                        height: 120,
                        width: 120,
                        margin: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: greyText),
                          image: state
                                  .selectAccount.selectAccount.avatar.isNotEmpty
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    state.selectAccount.selectAccount.avatar[0],
                                  ),
                                  onError: (exception, stackTrace) =>
                                      Image.asset(AppImages.logo),
                                )
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(AppIcons.camera),
                      )
                    : Container(
                        height: 120,
                        width: 120,
                        margin: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: greyText),
                          image: DecorationImage(
                            image: FileImage(
                              images!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
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
                  Row(
                    children: [
                      Expanded(
                        child: WTextField(
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
                          enabled:
                              state.selectAccount.selectAccount.status != 2,
                          hintText: "Name*",
                          controller: widget.vm.name,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: WTextField(
                          height: 56,
                          enabled:
                              state.selectAccount.selectAccount.status != 2,
                          onChanged: (value) {
                            widget.vm.latname.value = TextEditingValue(
                              text: Formatters.capitalize(value),
                              selection: widget.vm.latname.selection,
                            );
                            changeInfo();
                          },
                          inputFormatters: [Formatters.lotinFormat],
                          hintText: "Surname*",
                          textCapitalization: TextCapitalization.words,
                          controller: widget.vm.latname,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
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
                                    state.selectAccount.selectAccount.status !=
                                        2,
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
                                hintText: "Age*",
                                controller: widget.vm.age,
                                keyboardType: TextInputType.datetime,
                                suffix: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: SvgPicture.asset(AppIcons.calendar),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: GenderDropDown(
                            controller: widget.vm.gender,
                            onChange: () {
                              changeInfo();
                            },
                            isDisebled:
                                state.selectAccount.selectAccount.status == 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  WTextField(
                    height: 56,
                    onChanged: (value) {
                      changeInfo();
                    },
                    controller: widget.vm.region,
                    hintText: "Region",
                    readOnly: true,
                    enabled: state.selectAccount.selectAccount.status != 2,
                    onTap: () {
                      getRegionDialog();
                    },
                  ),
                  const SizedBox(height: 12),
                  WTextField(
                    height: 56,
                    onTap: () {
                      getProfissonDialog();
                    },
                    onChanged: (value) {
                      changeInfo();
                    },
                    controller: widget.vm.profession,
                    hintText: "Profession",
                    enabled: state.selectAccount.selectAccount.status != 2,
                    readOnly: true,
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
                          text: LocaleKeys.cartOrderCancelButton.tr(),
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
                            text: LocaleKeys.adduserMoveToOrder.tr(),
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
                            text: LocaleKeys.adduserSave.tr(),
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
