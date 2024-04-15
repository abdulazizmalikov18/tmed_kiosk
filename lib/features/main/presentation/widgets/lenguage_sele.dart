import 'dart:io';

import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class SelectLenguage extends StatefulWidget {
  const SelectLenguage({super.key, required this.selection});
  final int selection;

  @override
  State<SelectLenguage> createState() => _SelectLenguageState();
}

class _SelectLenguageState extends State<SelectLenguage> {
  int slection = 0;
  @override
  void initState() {
    slection = widget.selection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: contColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tilni tanlang',
                style: AppTheme.displayLarge.copyWith(fontSize: 20),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: AppIcons.closeCircle.svg(),
              )
            ],
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () {
              slection = 0;
              setState(() {});
            },
            child: Row(
              children: [
                Image.asset(
                  AppImages.uzFlag,
                  height: 28,
                  width: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  LocaleKeys.languageUz.tr(),
                  style:
                      AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: slection != 0 ? greyText : white,
                    border: slection == 0
                        ? Border.all(color: blue, width: 4)
                        : null,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              slection = 1;
              setState(() {});
            },
            child: Row(
              children: [
                Image.asset(
                  AppImages.ruFlag,
                  height: 28,
                  width: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  LocaleKeys.languageRu.tr(),
                  style:
                      AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: slection != 1 ? greyText : white,
                    border: slection == 1
                        ? Border.all(color: blue, width: 4)
                        : null,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          WButton(
            margin: Platform.isIOS ? const EdgeInsets.only(bottom: 24) : null,
            onTap: () {
              Navigator.pop(context, slection == 0 ? 'uz' : 'ru');
            },
            text: LocaleKeys.specialistCategory.tr(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
