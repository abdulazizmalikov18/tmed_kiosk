import 'package:tmed_kiosk/core/utils/formatters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/auth/domain/entity/flag_entity.dart';
import 'package:tmed_kiosk/features/auth/presentation/widgets/drop_down_flag.dart';
import 'package:tmed_kiosk/features/auth/presentation/widgets/tracking_text_input.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:tmed_kiosk/main.dart';
import 'package:lottie/lottie.dart';

part 'package:tmed_kiosk/features/auth/presentation/controllers/phone_input_mixin.dart';

class PhoneInputView extends StatefulWidget {
  const PhoneInputView({
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  @override
  State<PhoneInputView> createState() => _PhoneInputViewState();
}

class _PhoneInputViewState extends State<PhoneInputView> with PhoneInputMixin {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.back),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leadingWidth: 0,
          leading: const SizedBox(),
          title: Image.asset(
            $appType.logoImage,
            height: 36,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: DropDownFlag(
                width: 162,
                radius: 16,
                height: 40,
                items: lengu,
                selectedItem: selectedItem,
                filterFunction: () {
                  setState(() {});
                },
                color: white.withOpacity(.1),
              ),
            ),
            const SizedBox(width: 16)
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .07),
                Text(
                  LocaleKeys.loginToProfile.tr(),
                  style:
                      AppTheme.bodyMedium.copyWith(color: white, fontSize: 32),
                ),
                Text(
                  LocaleKeys.loginToContinue.tr(),
                  style: AppTheme.labelSmall.copyWith(fontSize: 16),
                ),
                Hero(
                  tag: "assets/anim/Teddy.flr",
                  child: SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: Lottie.asset(
                      'assets/anim/auth_anima.json',
                    ),
                    // child: FlareActor(
                    //   "assets/anim/Teddy.flr",
                    //   shouldClip: false,
                    //   alignment: Alignment.bottomCenter,
                    //   fit: BoxFit.contain,
                    //   controller: widget.bearLoginController,
                    // ),
                  ),
                ),
                TrackingTextInput(
                  hint: LocaleKeys.login.tr(),
                  controller: username,
                  inputFormatters: [Formatters.loginFormat],
                  onCaretMoved: (Offset? caret) {},
                  onTextChanged: (text) {
                    if (text.isEmpty) {
                      isCheckEmail = true;
                    } else {
                      isCheckEmail = false;
                    }
                    setState(() {});
                  },
                  textInputAction: TextInputAction.next,
                  isPhone: true,
                ),
                const SizedBox(height: 12),
                TrackingTextInput(
                  hint: LocaleKeys.enterPassword.tr(),
                  controller: password,
                  isObscured: true,
                  onCaretMoved: (Offset? caret) {},
                  onTextChanged: (String value) {
                    if (value.isEmpty) {
                      isCheckPas = true;
                    } else {
                      isCheckPas = false;
                    }
                    setState(() {});
                  },
                  textInputAction: TextInputAction.done,
                  isPhone: true,
                ),
                const SizedBox(height: 16),
                WButton(
                  onTap: () {
                    login();
                  },
                  isDisabled:
                      !(password.text.isNotEmpty && username.text.isNotEmpty),
                  isLoading: context.watch<AuthenticationBloc>().state.status ==
                      AuthenticationStatus.loading,
                  text: LocaleKeys.loginRegister.tr(),
                ),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.of(context).pop();
        //     },
        //     child: Container(
        //       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        //       decoration: BoxDecoration(color: contBlue, borderRadius: BorderRadius.circular(12)),
        //       child: RichText(
        //         text: TextSpan(
        //           text: "LocaleKeys.getJobThrough.tr()",
        //           style: AppTheme.labelSmall.copyWith(fontSize: 16),
        //           children: [
        //             TextSpan(
        //               text: "DASUTY?",
        //               style: AppTheme.labelSmall.copyWith(fontSize: 16, color: blue),
        //             )
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
