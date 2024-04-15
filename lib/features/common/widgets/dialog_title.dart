import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';

class DialogTitle extends StatelessWidget {
  const DialogTitle({super.key, required this.title, this.isBottom = true});
  final String title;
  final bool isBottom;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTheme.bodyMedium
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            WScaleAnimation(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.cancel, color: white),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(height: 1, color: greyText),
        if (isBottom) const SizedBox(height: 16),
      ],
    );
  }
}
