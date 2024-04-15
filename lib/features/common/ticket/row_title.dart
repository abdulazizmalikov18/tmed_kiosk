import 'package:pdf/widgets.dart' as pw;

class RowTitle extends pw.StatelessWidget {
  RowTitle({required this.title, required this.subtitle});
  String title;
  String subtitle;
  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Expanded(
          child: pw.Text(title, style: const pw.TextStyle(fontSize: 8)),
        ),
        pw.SizedBox(width: 12),
        pw.Expanded(
          child: pw.Text(
            subtitle,
            style: const pw.TextStyle(fontSize: 8),
            textAlign: pw.TextAlign.right,
          ),
        ),
      ],
    );
  }
}
