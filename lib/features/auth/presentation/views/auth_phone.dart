import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/auth/presentation/widgets/lenguage_select.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';
import 'package:tmed_kiosk/features/common/widgets/z_text_form_field.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:tmed_kiosk/main.dart';

class AuthPhoneView extends StatefulWidget {
  const AuthPhoneView({
    super.key,
    required this.formKey,
    required this.username,
    required this.password,
    required this.compController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController username;
  final TextEditingController password;
  final TextEditingController compController;

  @override
  State<AuthPhoneView> createState() => _AuthPhoneViewState();
}

class _AuthPhoneViewState extends State<AuthPhoneView> {
  bool isCheckEmail = false;
  bool isCheckPas = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                $appType.logoImage,
                height: 44,
              ),
              const Spacer(),
              LenguageSelect(
                onTap: () {
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Text(
            LocaleKeys.login_auth_text.tr(),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            LocaleKeys.login_auth_text_description.tr(),
            style: const TextStyle(
              fontSize: 18,
              color: greyText,
            ),
          ),
          const SizedBox(height: 24),
          WTextField(
            height: 56,
            hasError: isCheckEmail,
            controller: widget.username,
            fillColor: contColor,
            textColor: white,
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            onChanged: (value) {
              if (value.isEmpty) {
                isCheckEmail = true;
              } else {
                isCheckEmail = false;
              }
              setState(() {});
            },
            hintText: LocaleKeys.login_username.tr(),
            hintStyle: AppTheme.bodyLarge
                .copyWith(fontWeight: FontWeight.w400, color: white),
          ),
          const SizedBox(height: 16),
          ZTextFormField(
            height: 56,
            hasError: isCheckPas,
            controller: widget.password,
            fillColor: contColor,
            textColor: white,
            onChanged: (value) {
              if (value.isEmpty) {
                isCheckPas = true;
              } else {
                isCheckPas = false;
              }
              setState(() {});
            },
            isObscure: true,
            hintText: LocaleKeys.login_password.tr(),
            hintTextStyle: AppTheme.bodyLarge
                .copyWith(fontWeight: FontWeight.w400, color: white),
          ),
          const SizedBox(height: 24),
          WButton(
            height: 56,
            isDisabled: !(widget.password.text.isNotEmpty &&
                widget.username.text.isNotEmpty),
            isLoading: context.watch<AuthenticationBloc>().state.status ==
                AuthenticationStatus.loading,
            onTap: () {
              if (widget.formKey.currentState!.validate()) {
                context.read<AuthenticationBloc>().add(
                      LoginUser(
                        onError: (text) {
                          isCheckEmail = true;
                          isCheckPas = true;
                          var error = text;
                          if (error.toLowerCase().contains('dio') ||
                              error.toLowerCase().contains('type')) {
                            error = "User Topilmadi";
                          } else if (error.toLowerCase().contains('user')) {
                            error = "User Topilmadi";
                          }
                          context.read<ShowPopUpBloc>().add(ShowPopUp(
                                message: error,
                                status: PopStatus.error,
                              ));
                        },
                        password: widget.password.text,
                        userName: widget.username.text,
                        onSuccess: () {
                          StorageRepository.putString(
                            StorageKeys.COMPID,
                            widget.compController.text.toLowerCase(),
                          );
                        },
                      ),
                    );
              }
            },
            text: LocaleKeys.login_username.tr(),
          ),
        ],
      ),
    );
  }
}
