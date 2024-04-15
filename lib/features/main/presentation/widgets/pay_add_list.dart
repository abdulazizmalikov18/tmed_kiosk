import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/main/domain/entity/price_entity.dart';

class PayAddList extends StatelessWidget {
  const PayAddList({super.key, required this.entity});
  final MyPriceEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 48,
      decoration: wdecoration2,
      child: Row(
        children: [
          SvgPicture.asset(AppIcons.addCircle),
          const SizedBox(width: 12),
          if (entity.image == null)
            Text(
              entity.name,
              style: AppTheme.bodyLarge,
            )
          else
            Image.asset(
              entity.image!,
              height: 48,
              width: 92,
              alignment: Alignment.centerLeft,
            )
        ],
      ),
    );
  }
}
