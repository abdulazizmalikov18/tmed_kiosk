import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/common/entity/order_product_entity.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class OfferColumA4 extends pw.StatelessWidget {
  OfferColumA4({
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
    return pw.Container(
      decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(12),
        border: pw.Border.all(color: PdfColors.blue50),
      ),
      height: 28,
      margin: const pw.EdgeInsets.symmetric(vertical: 2),
      padding: const pw.EdgeInsets.symmetric(horizontal: 12),
      child: pw.Row(
        children: [
          pw.Expanded(
            flex: 1,
            child: pw.Text(
              (index + 1).toString(),
              style: const pw.TextStyle(fontSize: 8),
              textAlign: pw.TextAlign.center,
              maxLines: 1,
              overflow: pw.TextOverflow.visible,
            ),
          ),
          pw.Container(
            color: PdfColors.blue50,
            width: 1,
            height: double.infinity,
          ),
          pw.Expanded(
            flex: 10,
            child: pw.Text(
              product.name,
              style: const pw.TextStyle(fontSize: 8),
              textAlign: pw.TextAlign.left,
              maxLines: 2,
              overflow: pw.TextOverflow.visible,
            ),
          ),
          pw.Container(
            color: PdfColors.blue50,
            width: 1,
            height: double.infinity,
          ),
          pw.Expanded(
            flex: 4,
            child: pw.Text(
              product.id.toString(),
              style: const pw.TextStyle(fontSize: 8),
              textAlign: pw.TextAlign.center,
              maxLines: 1,
              overflow: pw.TextOverflow.visible,
            ),
          ),
          pw.Container(
            color: PdfColors.blue50,
            width: 1,
            height: double.infinity,
          ),
          pw.Expanded(
            flex: 4,
            child: pw.Text(
              product.qty.toString(),
              style: const pw.TextStyle(fontSize: 8),
              textAlign: pw.TextAlign.center,
              maxLines: 1,
              overflow: pw.TextOverflow.visible,
            ),
          ),
          pw.Container(
            color: PdfColors.blue50,
            width: 1,
            height: double.infinity,
          ),
          pw.Expanded(
            flex: 3,
            child: pw.Text(
              "уп",
              style: const pw.TextStyle(fontSize: 8),
              textAlign: pw.TextAlign.center,
              maxLines: 1,
              overflow: pw.TextOverflow.visible,
            ),
          ),
          pw.Container(
            color: PdfColors.blue50,
            width: 1,
            height: double.infinity,
          ),
          pw.Expanded(
            flex: 5,
            child: pw.Text(
              "${MyFunctions.getFormatCost((product.fullCost - (product.fullCost / 100 * vat)).toString())} UZS",
              style: const pw.TextStyle(fontSize: 8),
              textAlign: pw.TextAlign.right,
              maxLines: 1,
              overflow: pw.TextOverflow.visible,
            ),
          ),
          pw.Container(
            color: PdfColors.blue50,
            width: 1,
            height: double.infinity,
          ),
          pw.Expanded(
            flex: 5,
            child: pw.Text(
              "${MyFunctions.getFormatCost((product.fullCost / 100 * vat).toString())} UZS",
              style: const pw.TextStyle(fontSize: 8),
              textAlign: pw.TextAlign.center,
              maxLines: 1,
              overflow: pw.TextOverflow.visible,
            ),
          ),
          pw.Container(
            color: PdfColors.blue50,
            width: 1,
            height: double.infinity,
          ),
          pw.Expanded(
            flex: 5,
            child: pw.Text(
              "${MyFunctions.getFormatCost(product.fullCost.toString())} UZS",
              style: const pw.TextStyle(fontSize: 8),
              textAlign: pw.TextAlign.right,
              maxLines: 1,
              overflow: pw.TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
