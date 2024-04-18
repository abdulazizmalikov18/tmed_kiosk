import 'package:easy_localization/easy_localization.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/auth/presentation/widgets/time_widget.dart';
import 'package:flutter/material.dart';
// import 'package:flare_flutter/flare_actor.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:tmed_kiosk/main.dart';
import 'package:lottie/lottie.dart';

class AuthInfoCont extends StatelessWidget {
  const AuthInfoCont({
    super.key,
    required this.size,
  });
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: size.width * 0.45,
      color: context.color.contColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * .02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.height * .02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 64,
                        width: 146,
                        child: Image.asset($appType.logoImage,color: context.color.white,),
                      ),
                      Container(
                        width: 1,
                        height: 68,
                        color: greyText,
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TimeWidget(),
                          Text(
                            MyFunctions.getforDate(DateTime.now().toString()),
                            style: AppTheme.bodyMedium
                                .copyWith(color: greyText, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * .0586),
                  Text(
                    LocaleKeys.welcomeBusinessProfile.tr(),
                    style: AppTheme.bodyMedium
                        .copyWith(color: context.color.white, fontSize: 32),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    LocaleKeys.toStarted.tr(),
                    style: AppTheme.labelSmall
                        .copyWith(color: context.color.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.1),
            SizedBox(
              height: size.height * 0.2,
              width: double.infinity - 100,
              child: Lottie.asset(
                'assets/anim/auth_anima.json',
                fit: BoxFit.cover,
              ),
              // child: FlareActor(
              //   "assets/anim/Teddy.flr",
              //   shouldClip: false,
              //   alignment: Alignment.bottomCenter,
              //   fit: BoxFit.contain,
              //   controller: bearLoginController,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
