import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/colors/theme_changer.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:tmed_kiosk/features/common/navigation/routs_contact.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:tmed_kiosk/main.dart';

class InfoView extends StatelessWidget {
  const InfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 1400,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(AppImages.back_1),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(AppImages.back_2),
            ),
            Positioned.fill(
              child: Scaffold(
                backgroundColor: context.color.backGroundColor,
                body: Padding(
                  padding: const EdgeInsets.all(64),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),
                      Image.asset(
                        $appType.logoImage,
                        height: 60,
                        color: context.color.white,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        height: 692,
                        child: Lottie.asset(
                          'assets/anim/auth_anima.json',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(height: 56),
                      Text(
                        "welcome".tr(),
                        style: TextStyle(fontSize: 56, fontWeight: FontWeight.w600,color: context.color.white ),
                      ),
                      Text(
                        "sign_up_electronic_queue".tr(),
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w400,
                          color: white50,
                        ),
                      ),
                      const SizedBox(height: 56),
                      Row(
                        children: [
                          Expanded(
                            child: WButton(
                              height: 64,
                              color: context.color.white.withOpacity(.1),
                              onTap: () {
                                context.setLocale(const Locale("uz")).then(
                                    (value) => context
                                        .read<AuthenticationBloc>()
                                        .add(ChangeLanguageEvent("uz")));
                                context.go(RoutsContact.goods);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppImages.uzFlag,
                                    height: 32,
                                    width: 32,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    LocaleKeys.language_uz.tr(),
                                    style:
                                        AppTheme.bodyLarge.copyWith(fontSize: 24, color: context.color.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: WButton(
                              height: 64,
                              color: context.color.white.withOpacity(.1),
                              onTap: () {
                                context.setLocale(const Locale("ru")).then(
                                    (value) => context
                                        .read<AuthenticationBloc>()
                                        .add(ChangeLanguageEvent("ru")));
                                context.go(RoutsContact.goods);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppImages.ruFlag,
                                    height: 32,
                                    width: 32,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    LocaleKeys.language_ru.tr(),
                                    style: AppTheme.displayLarge
                                        .copyWith(fontSize: 24,color: context.color.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: WButton(
                              height: 64,
                              color: context.color.white.withOpacity(.1),
                              onTap: () {
                                context.setLocale(const Locale("en")).then(
                                    (value) => context
                                        .read<AuthenticationBloc>()
                                        .add(ChangeLanguageEvent("en")));
                                context.go(RoutsContact.goods);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppImages.engFlag,
                                    height: 32,
                                    width: 32,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                      LocaleKeys.language_en.tr(),
                                    style: AppTheme.displayLarge
                                        .copyWith(fontSize: 24,color: context.color.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                // floatingActionButton: BlocBuilder<PriceBloc, PriceState>(
                //   builder: (context, state) {
                //     return WButton(
                //       height: 40,
                //       width: 40,
                //       borderRadius: 12,
                //       onTap: () {
                //         context
                //             .read<PriceBloc>()
                //             .add(ModeControllerEvent(themeMode: !state.isMode));
                //         AppScope.update(
                //           context,
                //           AppScope(
                //               themeMode:
                //               AppScope.of(context).themeMode == ThemeMode.light
                //                   ? ThemeMode.dark
                //                   : ThemeMode.light),
                //         );
                //       },
                //       color: context.color.white.withOpacity(.1),
                //       child: state.isMode
                //           ? AppIcons.icMoon.svg(color: greyText)
                //           : AppIcons.icSun.svg(color: orang),
                //     );
                //   },
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
