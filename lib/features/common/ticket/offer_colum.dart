import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/common/entity/order_product_entity.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
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
    Log.wtf(product.coupon.id);
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        if (product.responsible.id != 0) ...[
          if (index != 0) PdfLine(length: 37),
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
          PdfLine(length: 37),
        ],
        RowTitle(
          title: product.name,
          subtitle:
              "${product.qty}x ${product.coupon.id != 0 ? "" : "${MyFunctions.getFormatCost(product.fullCost.toString())} UZS"}",
        ),
        if (product.coupon.id == 0)
          RowTitle(
            title: "QQS",
            subtitle:
                "$vat% ${MyFunctions.getFormatCost((product.fullCost / 100 * vat).toString())} UZS",
          )
        else ...[
          PdfLine(length: 37),
          RowTitle(
            title: "Tashkilot:",
            subtitle: product.coupon.name,
          ),
          PdfLine(length: 37),
        ],
        if (product.textCheck.isNotEmpty) ...[
          PdfLine(length: 37),
          pw.Row(children: [
            pw.Text(
              MyFunctions.parseHtmlString(product.textCheck),
              style: const pw.TextStyle(fontSize: 8),
              textAlign: pw.TextAlign.start,
            ),
          ]),
          PdfLine(length: 37),
        ]
      ],
    );
  }
}
