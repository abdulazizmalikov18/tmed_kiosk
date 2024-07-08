import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class RowTitle3 extends pw.StatelessWidget {
  RowTitle3({
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;
  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(12),
        border: pw.Border.all(color: PdfColors.blue50),
      ),
      margin: const pw.EdgeInsets.symmetric(vertical: 2),
      padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Text(
              title,
              style: const pw.TextStyle(fontSize: 8),
              textAlign: TextAlign.left,
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              subtitle,
              style: const pw.TextStyle(fontSize: 8),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
