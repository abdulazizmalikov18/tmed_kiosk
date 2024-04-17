import 'dart:io';

import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/theme_colors.dart';

abstract class AppTheme {
  static ThemeData lightTheme() => ThemeData(
        scaffoldBackgroundColor: AppThemeColor.light.backGroundColor,
        fontFamily: 'Museo_Sans_Cyrl',
        appBarTheme: AppBarTheme(
          elevation: 1,
          color: white,
          titleTextStyle: displayLarge.copyWith(fontSize: 18, color: dark),
          centerTitle: false,
          iconTheme: const IconThemeData(color: dark),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        unselectedWidgetColor: Colors.black,
        extensions: [AppThemeColor.light],
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: backGroundColor,
          dayBackgroundColor: MaterialStatePropertyAll(backGroundColor),
        ),
        textTheme: const TextTheme(
          displayLarge: displayLarge,
          displayMedium: displayMedium,
          displaySmall: displaySmall,
          headlineMedium: headlineMedium,
          headlineSmall: headlineSmall,
          titleLarge: titleLarge,
          bodyLarge: bodyLarge,
          bodyMedium: bodyMedium,
          titleMedium: titleMedium,
          titleSmall: titleSmall,
          bodySmall: bodySmall,
          labelLarge: labelLarge,
          labelSmall: labelSmall,
        ),
        colorScheme: const ColorScheme(
          background: white,
          brightness: Brightness.light,
          primary: blue,
          secondary: blue,
          error: red,
          surface: blue,
          onPrimary: blue,
          onSecondary: blue,
          onBackground: blue,
          onError: red,
          onSurface: blue,
        ),
        dialogTheme: const DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
        useMaterial3: true,
      );

  static ThemeData darkTheme() => ThemeData(
        scaffoldBackgroundColor: backGroundColor,
        fontFamily: 'Museo_Sans_Cyrl',
        appBarTheme: AppBarTheme(
          elevation: 1,
          color: contColor,
          titleTextStyle: displayLarge.copyWith(fontSize: 18),
          centerTitle: false,
          iconTheme: const IconThemeData(color: white),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        unselectedWidgetColor: Colors.black,
        extensions: [AppThemeColor.dark],
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: backGroundColor,
          dayBackgroundColor: MaterialStatePropertyAll(backGroundColor),
        ),
        textTheme: const TextTheme(
          displayLarge: displayLarge,
          displayMedium: displayMedium,
          displaySmall: displaySmall,
          headlineMedium: headlineMedium,
          headlineSmall: headlineSmall,
          titleLarge: titleLarge,
          bodyLarge: bodyLarge,
          bodyMedium: bodyMedium,
          titleMedium: titleMedium,
          titleSmall: titleSmall,
          bodySmall: bodySmall,
          labelLarge: labelLarge,
          labelSmall: labelSmall,
        ),
        colorScheme: const ColorScheme(
          background: white,
          brightness: Brightness.light,
          primary: blue,
          secondary: blue,
          error: red,
          surface: blue,
          onPrimary: blue,
          onSecondary: blue,
          onBackground: blue,
          onError: red,
          onSurface: blue,
        ),
        dialogTheme: const DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
        useMaterial3: true,
      );
  static ThemeData theme() => ThemeData(
        scaffoldBackgroundColor: scaffoldBackground,
        appBarTheme: const AppBarTheme(backgroundColor: contColor),
        useMaterial3: Platform.isAndroid || Platform.isIOS,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        unselectedWidgetColor: Colors.black,
        dialogTheme: const DialogTheme(backgroundColor: contColor),
        textTheme: const TextTheme(
          displayLarge: displayLarge,
          displayMedium: displayMedium,
          displaySmall: displaySmall,
          headlineMedium: headlineMedium,
          headlineSmall: headlineSmall,
          titleLarge: titleLarge,
          bodyLarge: bodyLarge,
          bodyMedium: bodyMedium,
          titleMedium: titleMedium,
          titleSmall: titleSmall,
          bodySmall: bodySmall,
          labelLarge: labelLarge,
          labelSmall: labelSmall,
        ),
        colorScheme: const ColorScheme(
          background: white,
          brightness: Brightness.dark,
          primary: blue,
          secondary: blue,
          error: red,
          surface: blue,
          onPrimary: white,
          onSecondary: white,
          onBackground: white,
          onError: red,
          onSurface: white,
        ),
      );

  // Fonts
  static const displayLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: white,
  );
  static const displayMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: white,
  );
  static const displaySmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: white,
  );
  static const headlineMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: white,
  );
  static const headlineSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: greyText,
  );
  static const titleLarge = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: white,
  );
  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: white,
  );

  static const bodyMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: white,
  );

  static const titleMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: white,
  );

  static const titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: white,
  );

  static const bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: white,
  );

  static const labelLarge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: white50,
    letterSpacing: -0.1,
  );

  static const labelSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: white50,
    letterSpacing: -0.1,
  );
}
