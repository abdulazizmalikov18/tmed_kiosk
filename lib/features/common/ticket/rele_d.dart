import 'package:pdf/widgets.dart' as pw;

class PdfLine extends pw.StatelessWidget {
  final int length;
  final String line;
  PdfLine({
    required this.length,
    this.line = '- ',
  });
  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: List.generate(
        length,
        (index) => pw.Text(line, style: const pw.TextStyle(fontSize: 8)),
      ),
    );
  }
}
