import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/auth/domain/entity/flag_entity.dart';
import 'package:tmed_kiosk/features/auth/presentation/views/phone_input_view.dart';
import 'package:tmed_kiosk/features/auth/presentation/widgets/drop_down_flag.dart';
import 'package:tmed_kiosk/features/common/navigation/presentation/navigator.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:tmed_kiosk/main.dart';
import 'package:lottie/lottie.dart';

part 'package:tmed_kiosk/features/auth/presentation/controllers/onboarding_mixin.dart';

class PhoneOnboarding extends StatefulWidget {
  const PhoneOnboarding({super.key});

  @override
  State<PhoneOnboarding> createState() => _PhoneOnboardingState();
}

class _PhoneOnboardingState extends State<PhoneOnboarding>
    with OnboardingMixin {
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
        body: Column(
          children: [
            Hero(
              tag: "assets/anim/Teddy.flr",
              child: SizedBox(
                height: 348,
                width: double.infinity,
                child: Lottie.asset(
                  'assets/anim/auth_anima.json',
                  fit: BoxFit.cover,
                ),
                // child: FlareActor(
                //   "assets/anim/Teddy.flr",
                //   shouldClip: false,
                //   alignment: Alignment.bottomCenter,
                //   fit: BoxFit.contain,
                //   controller: beraController,
                // ),
              ),
            ),
            const SizedBox(height: 60),
            Text(
              LocaleKeys.welcomeBusinessProfile.tr(),
              style: AppTheme.bodyMedium.copyWith(color: white, fontSize: 32),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              LocaleKeys.toStarted.tr(),
              style: AppTheme.labelSmall.copyWith(color: white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 64,
                width: 64,
                margin: const EdgeInsets.only(right: 16, bottom: 24),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) {
                          return wgradient.createShader(bounds);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(2),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(fade(
                          page: PhoneInputView(pageController: pageController),
                        ));
                      },
                      child: Container(
                        height: 48,
                        width: 48,
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: blue,
                          shape: BoxShape.circle,
                          boxShadow: wboxShadow,
                        ),
                        child: AppIcons.arrowRight.svg(color: white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
