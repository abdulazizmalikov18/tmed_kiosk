// ignore_for_file: use_build_context_synchronously

import 'package:tmed_kiosk/features/common/navigation/app_routs.dart';
import 'package:tmed_kiosk/features/common/navigation/routs_contact.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/core/singletons/dio_settings.dart';
import 'package:tmed_kiosk/core/singletons/service_locator.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tmed_kiosk/features/common/controllers/internet_bloc/internet_bloc.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/w_list_selection.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class SelectionLenguage extends StatefulWidget {
  const SelectionLenguage({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  State<SelectionLenguage> createState() => _SelectionLenguageState();
}

class _SelectionLenguageState extends State<SelectionLenguage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tilni tanlang'),
        const SizedBox(height: 24),
        WListSelection(
          onTap: () async {
            context.setLocale(const Locale('ru')).then((value) {
              EasyLocalization.ensureInitialized().then((value) {
                StorageRepository.putString('language', 'ru')!
                    .then((value) async {
                  serviceLocator<DioSettings>().setBaseOptions(lang: 'ru');
                  await resetLocator();
                  AppRouts.router.go(RoutsContact.goods);
                });
              });
            });
          },
          title: LocaleKeys.language_ru.tr(),
          isLenguage: true,
        ),
        const SizedBox(height: 24),
        WListSelection(
          onTap: () {
            context.setLocale(const Locale('uz')).then((value) {
              EasyLocalization.ensureInitialized().then((value) {
                StorageRepository.putString('language', 'uz')!
                    .then((value) async {
                  serviceLocator<DioSettings>().setBaseOptions(lang: 'uz');
                  await resetLocator();
                  AppRouts.router.go(RoutsContact.goods);
                });
              });
            });
          },
          title: LocaleKeys.language_uz.tr(),
          isLenguage: true,
        ),
        const SizedBox(height: 24),
        WListSelection(
          onTap: () {
            widget._pageController.animateToPage(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          },
          title: LocaleKeys.language_en.tr(),
          isLenguage: true,
        ),
      ],
    );
  }
}
