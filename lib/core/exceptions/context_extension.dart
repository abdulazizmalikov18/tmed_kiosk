import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/theme_colors.dart';

extension BuildContexExt on BuildContext {
  AppThemeColor get color => Theme.of(this).extension<AppThemeColor>()!;
}
