import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/info_price_row.dart';

class PriceInfoPhone extends StatelessWidget {
  const PriceInfoPhone({
    super.key,
    required this.allPrice,
    required this.discount,
    required this.isOrder,
    required this.avans,
    required this.moneyEntered,
    required this.vat,
  });

  final int allPrice;
  final int discount;
  final bool isOrder;
  final int avans;
  final int moneyEntered;
  final int vat;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: greyText),
      ),
      margin: const EdgeInsets.only(top: 16),
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
          if (isOrder)
            InfoPriceRow(
              name: 'Kiritilgan Pul:',
              price: avans,
              type: 'UZS',
            ),
          InfoPriceRow(
            name: 'Qaytim:',
            price: moneyEntered - allPrice > 0 ? moneyEntered - allPrice : 0,
            type: 'UZS',
          ),
          InfoPriceRow(
            name: 'Kiritilgan Pul:',
            price: moneyEntered,
            type: 'UZS',
          ),
        ],
      ),
    );
  }
}
