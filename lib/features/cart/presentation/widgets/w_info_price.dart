import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/info_price_row.dart';
import 'package:flutter/material.dart';

class WInfoPrice extends StatelessWidget {
  const WInfoPrice(
      {super.key,
      required this.allPrice,
      required this.discount,
      required this.vat});

  final int allPrice;
  final int discount;
  final int vat;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: wdecoration2,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total price',
            style: AppTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const Divider(height: 24, color: greyText),
          InfoPriceRow(
            name: 'Narxi:',
            price: allPrice,
            type: 'UZS',
          ),
          InfoPriceRow(
            name: 'QQS:',
            price: (allPrice * (vat / 100)).toInt(),
            type: '$vat %',
          ),
          InfoPriceRow(
            name: 'Chegirma:',
            price: discount,
            type: 'UZS',
          ),
        ],
      ),
    );
  }
}
