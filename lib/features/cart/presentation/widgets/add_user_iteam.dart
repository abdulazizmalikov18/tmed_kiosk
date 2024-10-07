import 'dart:io';

import 'package:dio/dio.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/core/utils/download_file.dart';
import 'package:tmed_kiosk/core/utils/formatters.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_model.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/profession_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/region_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/chech_order_dialog.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/user_camera_macos.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

part 'package:tmed_kiosk/features/cart/presentation/controllers/add_user_contoller.dart';

class AddUsetIteam extends StatefulWidget {
  const AddUsetIteam({
    super.key,
    required this.vm,
    this.isNew = false,
    this.isChanged = false,
    this.url = "",
    required this.vmC,
  });

  final AccountsViewModel vm;
  final CartViewModel vmC;
  final bool isNew;
  final bool isChanged;
  final String url;

  @override
  State<AddUsetIteam> createState() => _AddUsetIteamState();
}

class _AddUsetIteamState extends State<AddUsetIteam> with AddUserViweModel {
  late final DownloadFile _downloadFile = DownloadFile(
    file: widget.url,
    setState: setState,
  );

  @override
  void initState() {
    super.initState();
    _downloadFile.initFile();
    if (isChanged.value) {
      changeInfo();
    }
    if (widget.url.isNotEmpty) {
      downloadImage();
    }
  }

  void downloadImage() async {
    changeInfo();
    _downloadFile.fileExists && !_downloadFile.dowloading ? await _downloadFile.openfile() : await _downloadFile.startDownload();
    if (_downloadFile.fileExists) {
      images = File(_downloadFile.filePath);
      Log.d("Yes");
      setState(() {});
    }
  }

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
                        height: 160,
                        width: 160,
                        margin: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: greyText),
                          image: state.selectAccount.selectAccount.avatar.isNotEmpty
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    state.selectAccount.selectAccount.avatar[0],
                                  ),
                                  onError: (exception, stackTrace) => Image.asset(AppImages.logo),
                                )
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: AppIcons.camera.svg(),
                      )
                    : Container(
                        height: 160,
                        width: 160,
                        margin: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: greyText),
                          image: DecorationImage(
                            image: FileImage(images!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: _downloadFile.dowloading
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    value: _downloadFile.progress,
                                    strokeWidth: 3,
                                    backgroundColor: context.color.white,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      context.color.blue,
                                    ),
                                  ),
                                  Text(
                                    (_downloadFile.progress * 100).toStringAsFixed(2),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              )
                            : null,
                      ),
              ),
              if (!widget.isNew)
                WButton(
                  onTap: () {},
                  width: 350,
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  textStyle: const TextStyle(fontSize: 28),
                  text: state.selectAccount.selectAccount.phone.isNotEmpty ? "+${state.selectAccount.selectAccount.phone}" : "PNFL ${state.selectAccount.selectAccount.pinfl}",
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
                    cursorHeight: 50,
                    height: 100,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
                    hintStyle: TextStyle(fontSize: 32, color: context.color.white.withOpacity(.5)),
                    style: TextStyle(color: context.color.white, fontSize: 32),
                  ),
                  WTextField(
                    cursorHeight: 50,
                    height: 100,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
                    hintStyle: TextStyle(fontSize: 32, color: context.color.white.withOpacity(.5)),
                    style: TextStyle(color: context.color.white, fontSize: 32),
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
                          cursorHeight: 50,
                          height: 100,
                          keyboardType: TextInputType.number,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          enabled: state.selectAccount.selectAccount.status != 2,
                          inputFormatters: [Formatters.dateFormatter],
                          onChanged: (value) {
                            // if(!RegExp("[0-9]").hasMatch(value[value.length-1])){
                            //   widget.vm.age.text = value.substring(0, value.length-2);
                            // }
                            if (value.length == 3 && value[value.length - 1] != "/") {
                              widget.vm.age.text = "${value.substring(0, 2)}/${value[2]}";
                            }
                            if (value.length == 6 && value[value.length - 1] != "/") {
                              widget.vm.age.text = "${value.substring(0, 5)}/${value[5]}";
                            }
                            if (value.length >= 9) {
                              widget.vm.age.text = value;
                            }
                            changeInfo();
                            if (value.length == 10) {
                              _dateFormKey.currentState!.validate();
                            } else if (value.length >= 2 && int.tryParse(value.substring(0, 2))! >= 32) {
                              widget.vm.age.text = value.replaceRange(0, 2, "30");
                              // "30";
                            } else if (value.length >= 5 && int.tryParse(value.substring(3, 5))! >= 12) {
                              widget.vm.age.text = value.replaceRange(3, 5, "02");
                              // "02";
                            } else if (value.length >= 9 && int.tryParse(value.substring(6, 9))! >= 2025) {
                              widget.vm.age.text = value.replaceRange(6, 10, "2000");
                              // "2024";
                            }
                          },
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              if (parseDate(value) != null) {
                                Log.w(parseDate(value));
                                return null;
                              } else {
                                Log.e("NImagp");
                                return "nod_date_tIme".tr();
                              }
                            } else {
                              return null;
                            }
                          },
                          hintText: "${LocaleKeys.age.tr()}*",
                          hintStyle: TextStyle(fontSize: 32, color: context.color.white.withOpacity(.5)),
                          controller: widget.vm.age,
                          fillColor: context.color.whiteBlack,
                          style: TextStyle(color: context.color.white, fontSize: 32),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
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
                          textStyle: const TextStyle(fontSize: 32),
                          height: 100,
                          onTap: () {
                            context.pop();
                            widget.vm.clearAccount(context);
                          },
                          color: red,
                          isDisabled: context.read<CartBloc>().state.isOrder.isNotEmpty,
                          text: LocaleKeys.cart_order_cancel_button.tr(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (!widget.isNew) ...[
                        Expanded(
                          child: WButton(
                            textStyle: const TextStyle(fontSize: 32),
                            height: 100,
                            onTap: () {
                              if (widget.vm.isCreat) {
                                if (_dateFormKey.currentState!.validate()) {
                                  createUser();
                                }
                              }
                              context.pop();
                            },
                            color: green,
                            isLoading: state.statusOrder.isInProgress,
                            text: LocaleKeys.adduser_move_to_order.tr(),
                          ),
                        ),
                        if (state.selectAccount.selectAccount.status != 2 && widget.isNew) const SizedBox(width: 16),
                      ],
                      if (state.selectAccount.selectAccount.status != 2 && widget.isNew)
                        Expanded(
                          child: ValueListenableBuilder(
                              valueListenable: isDis,
                              builder: (context, ss, __) {
                                return WButton(
                                  height: 100,
                                  textStyle: const TextStyle(fontSize: 32),
                                  isLoading: state.status.isInProgress,
                                  isDisabled: !ss & widget.isNew,
                                  onTap: () {
                                    if (widget.vm.isCreat) {
                                      if (_dateFormKey.currentState!.validate()) {
                                        createUser();
                                      }
                                    } else {
                                      if (_dateFormKey.currentState!.validate()) {
                                        createUser();
                                      }
                                    }
                                  },
                                  text: LocaleKeys.adduser_save.tr(),
                                );
                              }),
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
