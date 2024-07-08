import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class RowTitle2 extends pw.StatelessWidget {
  RowTitle2({
    required this.title1,
    required this.title2,
    required this.title3,
    required this.title4,
  });
  final String title1;
  final String title2;
  final String title3;
  final String title4;
  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Text(
              title1,
              textAlign: TextAlign.left,
              style: const pw.TextStyle(fontSize: 8),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              title2,
              textAlign: TextAlign.right,
              style: const pw.TextStyle(fontSize: 8),
            ),
          ),
          pw.SizedBox(width: 16),
          pw.Expanded(
            child: pw.Text(
              title3,
              textAlign: TextAlign.left,
              style: const pw.TextStyle(fontSize: 8),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              title4,
              textAlign: TextAlign.right,
              style: const pw.TextStyle(fontSize: 8),
            ),
          )
        ],
      ),
    );
  }
}
