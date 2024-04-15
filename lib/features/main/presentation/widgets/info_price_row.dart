import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';

class InfoPriceRow extends StatelessWidget {
  const InfoPriceRow({
    super.key,
    required this.name,
    required this.type,
    required this.price,
    this.subName = "",
    this.isDiscount = false,
  });
  final String name;
  final String type;
  final int price;
  final String subName;
  final bool isDiscount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            name,
            style: AppTheme.labelLarge.copyWith(color: white.withOpacity(.5)),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            type,
            style: AppTheme.labelLarge.copyWith(color: white.withOpacity(.5)),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            subName.isEmpty
                ? '${MyFunctions.getThousandsSeparatedPrice(price > 0 ? price.toString() : (price * -1).toString())} UZS'
                : subName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppTheme.displayLarge.copyWith(
              color: isDiscount
                  ? price != 0
                      ? price > 0
                          ? red
                          : green
                      : null
                  : null,
            ),
            textAlign: TextAlign.end,
          ),
        )
      ],
    );
  }
}
