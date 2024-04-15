import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationChecker {
  static changeLanguge(BuildContext context) {
    Locale? currentLocal = EasyLocalization.of(context)!.currentLocale;
    if (currentLocal == const Locale('uz')) {
      EasyLocalization.of(context)!.setLocale(const Locale('ru'));
    } else {
      EasyLocalization.of(context)!.setLocale(const Locale('uz'));
    }
  }
}
