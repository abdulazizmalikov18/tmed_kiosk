import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:flutter/services.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/main.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const SplashView());

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBody: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.back),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40),
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Image.asset(
              $appType.logoImage,
              fit: BoxFit.contain,
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: const EdgeInsets.only(bottom: 32),
          child: const Center(child: CircularProgressIndicator(color: white)),
        ),
      ),
    );
  }
}
