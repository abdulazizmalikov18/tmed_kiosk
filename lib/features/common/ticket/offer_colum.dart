import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/common/entity/order_product_entity.dart';
import 'package:tmed_kiosk/features/common/ticket/rele_d.dart';
import 'package:tmed_kiosk/features/common/ticket/row_title.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pdf/widgets.dart' as pw;

class OfferColum extends pw.StatelessWidget {
  OfferColum({
    required this.product,
    required this.index,
    required this.vat,
  });
  final OrderProductEntity product;
  final int index;
  final int vat;
  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        if (product.responsible.id != 0) ...[
          if (index != 0) PdfLine(length: 47),
          RowTitle(
            title: LocaleKeys.check_specialist.tr(),
            subtitle:
                "${product.responsible.lastname} ${product.responsible.lastname}",
          ),
          pw.SizedBox(height: 2),
          RowTitle(
            title: LocaleKeys.check_profession.tr(),
            subtitle: product.responsible.job,
          ),
          PdfLine(length: 47),
        ],
        RowTitle(
          title: product.name,
          subtitle:
              "${product.qty}x ${MyFunctions.getFormatCost(product.fullCost.toString())} UZS",
        ),
        RowTitle(
          title: "QQS",
          subtitle:
              "$vat% ${MyFunctions.getFormatCost((product.fullCost / 100 * vat).toString())} UZS",
        ),
      ],
    );
  }
}
