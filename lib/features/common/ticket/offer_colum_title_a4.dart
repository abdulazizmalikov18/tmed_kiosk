import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class OfferColumTitleA4 extends pw.StatelessWidget {
  OfferColumTitleA4({
    required this.title1,
    required this.title2,
    required this.title3,
    required this.title4,
    required this.title5,
    required this.title6,
    required this.title7,
    required this.title8,
  });
  final String title1;
  final String title2;
  final String title3;
  final String title4;
  final String title5;
  final String title6;
  final String title7;
  final String title8;

  @override
  pw.Widget build(pw.Context context) {
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
              title1,
              style: pw.TextStyle(
                fontSize: 8,
                fontWeight: pw.FontWeight.bold,
              ),
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
              title2,
              style: pw.TextStyle(
                fontSize: 8,
                fontWeight: pw.FontWeight.bold,
              ),
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
              title3,
              style: pw.TextStyle(
                fontSize: 8,
                fontWeight: pw.FontWeight.bold,
              ),
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
              title4,
              style: pw.TextStyle(
                fontSize: 8,
                fontWeight: pw.FontWeight.bold,
              ),
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
              title5,
              style: pw.TextStyle(
                fontSize: 8,
                fontWeight: pw.FontWeight.bold,
              ),
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
              title6,
              style: pw.TextStyle(
                fontSize: 8,
                fontWeight: pw.FontWeight.bold,
              ),
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
              title7,
              style: pw.TextStyle(
                fontSize: 8,
                fontWeight: pw.FontWeight.bold,
              ),
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
              title8,
              style: pw.TextStyle(
                fontSize: 8,
                fontWeight: pw.FontWeight.bold,
              ),
              textAlign: pw.TextAlign.center,
              maxLines: 1,
              overflow: pw.TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
