import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/core/utils/formatters.dart';
import 'package:tmed_kiosk/core/utils/size_config.dart';
import 'package:tmed_kiosk/features/auth/domain/entity/flag_entity.dart';
import 'package:tmed_kiosk/features/auth/presentation/views/phone_onboarding.dart';
import 'package:tmed_kiosk/features/auth/presentation/widgets/drop_down_flag.dart';
import 'package:tmed_kiosk/features/auth/presentation/widgets/tracking_text_input.dart';
import 'package:tmed_kiosk/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/auth/presentation/widgets/auth_info_cont.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/internet_bloc/internet_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/features/common/user_type/user_type.dart';
import 'package:tmed_kiosk/features/common/view/internet_error_bottomsheet.dart';
import 'package:tmed_kiosk/features/common/widgets/custom_screen.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

part 'package:tmed_kiosk/features/auth/presentation/controllers/controllers.dart';

class AuthMainView extends StatefulWidget {
  const AuthMainView({super.key});

  @override
  State<AuthMainView> createState() => _AuthMainViewState();
}

class _AuthMainViewState extends State<AuthMainView> with AuthMainMixin {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (!state.isConnected) {
            isBtmSheetOpened = true;
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.transparent,
                insetPadding: const EdgeInsets.all(0),
                content: InternetErrorBottomSheet(
                  onTap: () {
                    context
                        .read<InternetBloc>()
                        .add(GlobalCheck(isConnected: state.isConnected));
                  },
                ),
              ),
            );
          } else if (isBtmSheetOpened && state.isConnected) {
            isBtmSheetOpened = false;
            Navigator.of(context).pop();
          }
        });
      },
      child: CustomScreen(
        child: KeyboardDismisser(
          child: Form(
            key: formKey,
            child: Scaffold(
              backgroundColor: context.color.scaffoldBackground,
              body: size.width >= 601
                  ? Row(
                children: [
                  AuthInfoCont(
                    size: MediaQuery.of(context).size,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                DropDownFlag(
                                  width: SizeConfig.v(162),
                                  height: SizeConfig.v(48),
                                  radius: 16,
                                  items: lengu,
                                  selectedItem: selectedItem,
                                  filterFunction: () {
                                    context
                                        .setLocale(Locale(
                                        selectedItem.value.type))
                                        .then((value) => context
                                        .read<AuthenticationBloc>()
                                        .add(ChangeLanguageEvent(
                                        selectedItem
                                            .value.type)));
                                    setState(() {});
                                  },
                                  color:
                                  context.color.white.withOpacity(.1),
                                ),
                              ],
                            ),
                          ),
                          ConstrainedBox(
                            constraints:
                            const BoxConstraints(maxWidth: 500),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        .06),
                                Text(
                                  LocaleKeys.login_auth_text.tr(),
                                  style: AppTheme.bodyMedium.copyWith(
                                      color: context.color.white,
                                      fontSize: 60),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  LocaleKeys.login_auth_text_description
                                      .tr(),
                                  style: AppTheme.labelSmall
                                      .copyWith(fontSize: 24),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 64),
                                TrackingTextInput(
                                  hint: LocaleKeys.login.tr(),
                                  controller: username,
                                  inputFormatters: [
                                    Formatters.loginFormat
                                  ],
                                  onCaretMoved: (Offset? caret) {
                                    // bearLoginController.coverEyes(caret == null);
                                    // bearLoginController.lookAt(caret);
                                  },
                                  onTextChanged: (text) {
                                    if (text.isEmpty) {
                                      isCheckEmail = true;
                                    } else {
                                      isCheckEmail = false;
                                    }
                                    setState(() {});
                                  },
                                  textInputAction: TextInputAction.next,
                                  isPhone: false,
                                ),
                                const SizedBox(height: 24),
                                TrackingTextInput(
                                  hint: LocaleKeys.enterPassword.tr(),
                                  controller: password,
                                  isObscured: true,
                                  onCaretMoved: (Offset? caret) {
                                    // bearLoginController.coverEyes(caret != null);
                                    // bearLoginController.lookAt(null);
                                  },
                                  onEditingComplete: () {
                                    login();
                                  },
                                  onTextChanged: (String value) {
                                    // bearLoginController.setPassword(value);
                                    if (value.isEmpty) {
                                      isCheckPas = true;
                                    } else {
                                      isCheckPas = false;
                                    }
                                    setState(() {});
                                  },
                                  textInputAction: TextInputAction.done,
                                  isPhone: false,
                                ),
                                const SizedBox(height: 6),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      LocaleKeys.forgot_your_password
                                          .tr(),
                                      style: AppTheme.labelSmall.copyWith(
                                          fontSize: 16, color: blue),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                WButton(
                                  height: 56,
                                  isDisabled:
                                  !(password.text.isNotEmpty &&
                                      username.text.isNotEmpty),
                                  isLoading: context
                                      .watch<AuthenticationBloc>()
                                      .state
                                      .status ==
                                      AuthenticationStatus.loading,
                                  onTap: () {
                                    login();
                                  },
                                  text: LocaleKeys.login_username.tr(),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        .19),
                                Text("App version: $appVersion"),
                                const SizedBox(height: 48),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
              // : AuthPhoneView(
              //     formKey: formKey,
              //     username: username,
              //     password: password,
              //     compController: compController,
              //   ),
                  : const PhoneOnboarding(),
            ),
          ),
        ),
      ),
    );
  }
}
