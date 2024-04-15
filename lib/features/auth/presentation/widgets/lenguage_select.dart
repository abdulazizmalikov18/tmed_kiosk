import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

enum SampleItem { uz, ru, en, kz }

class LenguageSelect extends StatefulWidget {
  const LenguageSelect({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  State<LenguageSelect> createState() => _LenguageSelectState();
}

class _LenguageSelectState extends State<LenguageSelect> {
  SampleItem selectedMenu = SampleItem.uz;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<SampleItem>(
        isExpanded: true,
        customButton: Container(
          height: 24,
          margin: const EdgeInsets.all(8),
          child: Row(
            children: [
              SvgPicture.asset(
                AppIcons.global,
                colorFilter: const ColorFilter.mode(blue, BlendMode.srcIn),
              ),
              const SizedBox(width: 8),
              Text(
                MyFunctions.getType(selectedMenu),
                style: AppTheme.bodyLarge.copyWith(color: blue),
              ),
            ],
          ),
        ),
        items: [
          DropdownMenuItem<SampleItem>(
            onTap: () {
              context.setLocale(const Locale('ru'));
              context.read<AuthenticationBloc>().add(ChangeLanguageEvent('ru'));
            },
            value: SampleItem.ru,
            child: Text(
              LocaleKeys.languageRu.tr(),
              style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          DropdownMenuItem<SampleItem>(
            onTap: () async {
              context.setLocale(const Locale('uz'));
              context.read<AuthenticationBloc>().add(ChangeLanguageEvent('uz'));
            },
            value: SampleItem.uz,
            child: Text(
              LocaleKeys.languageUz.tr(),
              style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          DropdownMenuItem<SampleItem>(
            onTap: () {
              context.setLocale(const Locale('uz'));
            },
            value: SampleItem.en,
            child: Text(
              LocaleKeys.languageEn.tr(),
              style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ],
        value: selectedMenu,
        onChanged: (value) {
          setState(() {
            selectedMenu = value!;
          });
          widget.onTap();
        },
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: white,
          ),
          overlayColor: MaterialStateProperty.all(white),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 220,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(0),
          elevation: 2,
        ),
        menuItemStyleData: const MenuItemStyleData(height: 48),
      ),
    );
  }
}
