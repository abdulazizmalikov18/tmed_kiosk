// import 'package:tmed_kiosk/core/utils/my_function.dart';
// import 'package:tmed_kiosk/features/kassa/domain/entity/kassa_payment_entity.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';

// import 'package:tmed_kiosk/features/common/ticket/base_receipt_widget.dart';
// import 'package:tmed_kiosk/features/common/ticket/rele_d.dart';
// import 'package:tmed_kiosk/features/common/ticket/row_title.dart';

// class XZreportTicket extends BaseReceiptWidget {
//   final List<KassaPaymentEntity> payment;
//   XZreportTicket({required this.payment});
//   // final image =
//   //     pw.MemoryImage(File("assets/images/tmed_terminal.png").readAsBytesSync());
//   @override
//   pw.Widget build(pw.Context context) {
//     return pw.Padding(
//       padding: const pw.EdgeInsets.only(right: 28),
//       child: pw.Column(
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         children: [
//           // pw.Center(child: pw.Image(image)),
//           pw.Container(
//             padding: const pw.EdgeInsets.only(top: 8),
//             alignment: Alignment.center,
//             child: pw.Text(
//               'Markaziy Temir Yo\'l Poliklinikasi',
//               style: pw.TextStyle(
//                 fontSize: 10,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//             ),
//           ),
//           PdfLine(length: 47),
//           pw.Container(
//             alignment: Alignment.center,
//             padding: const pw.EdgeInsets.symmetric(horizontal: 8),
//             child: pw.Text(
//               'Toshkent sh.M.Ulugbek tum. Labzak kochasi 12',
//               style: const pw.TextStyle(fontSize: 8),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           ...List.generate(
//             payment.length,
//             (index) => RowTitle(
//               title: MyFunctions.payment(payment[index].payment),
//               subtitle:
//                   "${MyFunctions.priceFormat(payment[index].totalOrdersCost)} UZS",
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Future<Uint8List> show() async {
//     pw.Document pdf = pw.Document(version: PdfVersion.pdf_1_5);
//     pdf.addPage(pw.Page(
//       build: (context) => this,
//       pageFormat: PdfPageFormat.roll80,
//       theme: pw.ThemeData.withFont(
//         bold: Font.ttf(
//             await rootBundle.load("assets/fonts/arial_bolditalicmt.ttf")),
//       ),
//     ));
//     return await pdf.save();
//   }
// }
