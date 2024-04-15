import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/images.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';

class WListSelection extends StatelessWidget {
  const WListSelection(
      {super.key,
      required this.onTap,
      required this.title,
      this.image = '',
      this.isLenguage = false,
      this.isText = false,
      this.lenguage = 'uz'});
  final VoidCallback onTap;
  final String title;
  final String image;
  final bool isLenguage;
  final bool isText;
  final String lenguage;

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: onTap,
      child: SizedBox(
        height: 24,
        child: Row(
          children: [
            if (image.isNotEmpty)
              SvgPicture.asset(
                image,
                colorFilter: const ColorFilter.mode(white, BlendMode.srcIn),
              ),
            if (image.isNotEmpty) const SizedBox(width: 16),
            Text(
              title,
              style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            if (isLenguage)
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: greyText,
                  image: DecorationImage(
                    image: lenguage == 'uz'
                        ? const AssetImage(AppImages.uzFlag)
                        : const AssetImage(AppImages.ruFlag),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (isText)
              Text(
                "UZS",
                style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w400),
              )
          ],
        ),
      ),
    );
  }
}
