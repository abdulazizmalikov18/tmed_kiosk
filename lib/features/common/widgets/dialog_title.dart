import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
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
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w700, color: context.color.white),
            ),
            WScaleAnimation(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.cancel, color: greyText),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Divider(height: 1, color: context.color.white.withOpacity(.1)),
        if (isBottom) const SizedBox(height: 16),
      ],
    );
  }
}
