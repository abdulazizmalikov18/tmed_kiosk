import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/surcharge_entity.dart';

class SelectionButton extends StatelessWidget {
  const SelectionButton({
    super.key,
    required this.selectIndex,
    required this.discount,
    required this.index,
    required this.size,
  });

  final int selectIndex;
  final SurchargeEntity discount;
  final int index;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: size >= 590 ? 28 : 12,
      ),
      margin: size >= 590
          ? const EdgeInsets.fromLTRB(0, 0, 12, 24)
          : const EdgeInsets.only(bottom: 8, right: 8),
      decoration: BoxDecoration(
        boxShadow: wboxShadow,
        color: selectIndex == index ? null : white,
        gradient: selectIndex == index
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[lightBlue, blue],
              )
            : null,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        discount.value > 0
            ? "${discount.value.toInt()}% qo'shimcha to'lov"
            : "${discount.value.toInt().abs()}% Chegirma",
        style: AppTheme.labelSmall.copyWith(
          color: selectIndex == index ? white : greyText,
        ),
      ),
    );
  }
}
