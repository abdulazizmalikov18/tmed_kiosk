import 'package:easy_localization/easy_localization.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';

class NoDataCart extends StatelessWidget {
  const NoDataCart({
    super.key,
    this.image = AppIcons.cosmoCart,
    this.title = 'Vazifa yoq',
    this.isButton = false,
  });
  final String image;
  final String title;
  final bool isButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 308,
      constraints: const BoxConstraints(maxHeight: 456),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.color.contColor,
        boxShadow: wboxShadow,
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SvgPicture.asset(image),
          ),
          Container(
            height: 28,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 12),
            transformAlignment: Alignment.center,
            child: Text(
              title,
              style: AppTheme.bodyMedium,
            ),
          ),
          if (!isButton)
            Container(
              height: 28,
              alignment: Alignment.center,
              transformAlignment: Alignment.center,
              child: Text(
                "select_a_task".tr(),
                style: AppTheme.headlineSmall
                    .copyWith(fontWeight: FontWeight.w400,color: context.color.white),
              ),
            ),
          if (isButton)
            WButton(
              onTap: () {},
              text: 'loading'.tr(),
            ),
        ],
      ),
    );
  }
}
