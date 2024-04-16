// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/accounts_view_model.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class UserBottomButton extends StatelessWidget {
  const UserBottomButton({
    super.key,
    required this.vm,
    required this.images,
  });

  final AccountsViewModel vm;
  final File? images;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(color: contColor, boxShadow: wboxShadow),
          child: Row(
            children: [
              if (state.selectAccount.selectAccount.name.isNotEmpty)
                Expanded(
                  child: WButton(
                    onTap: () {
                      vm.clearAccount(context);
                    },
                    margin: const EdgeInsets.only(right: 16),
                    color: red,
                    text: LocaleKeys.cart_order_cancel_button.tr(),
                  ),
                ),
              Expanded(
                child: WButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  color: green,
                  isDisabled: state.selectAccount.selectAccount.name.isEmpty,
                  text: LocaleKeys.adduser_move_to_order.tr(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: WButton(
                  isLoading: state.status.isInProgress,
                  onTap: () async {
                    FormData formData = vm.phone.text[0] == "+"
                        ? FormData.fromMap({
                            "name": vm.name.text,
                            "gender": vm.gender.text,
                            "profession": vm.profession.text,
                            "lastname": vm.latname.text,
                            "birthday": "2001-08-23",
                            "region": "",
                            "pvc": "000000",
                            "phone": vm.phone.text,
                            "surname": vm.latname.text,
                            "avatar": images != null
                                ? await MultipartFile.fromFile(images!.path)
                                : images
                          })
                        : FormData.fromMap({
                            "name": vm.name.text,
                            "gender": vm.gender.text,
                            "profession": vm.profession.text,
                            "lastname": vm.latname.text,
                            "birthday": "2001-08-23",
                            "region": "",
                            "pvc": "000000",
                            "pinfl": vm.phone.text,
                            "surname": vm.latname.text,
                            "avatar": images != null
                                ? await MultipartFile.fromFile(images!.path)
                                : images
                          });
                    context.read<AccountsBloc>().add(
                          CreateAccount(
                            formData: formData,
                            onSucces: () {
                              context.read<ShowPopUpBloc>().add(ShowPopUp(
                                  message: "User Yaratildi",
                                  status: PopStatus.success));
                            },
                            onError: () {
                              context.read<ShowPopUpBloc>().add(ShowPopUp(
                                  message: "User Yaratilmadi",
                                  status: PopStatus.error));
                            },
                          ),
                        );
                  },
                  text: LocaleKeys.adduser_save.tr(),
                  isDisabled: (vm.phone.text.isNotEmpty &&
                      vm.latname.text.isEmpty &&
                      vm.name.text.isEmpty),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
