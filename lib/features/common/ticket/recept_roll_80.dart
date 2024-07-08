// import 'dart:io';

import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/common/entity/orders_entity.dart';
import 'package:tmed_kiosk/features/common/ticket/offer_colum.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import 'package:tmed_kiosk/features/common/ticket/base_receipt_widget.dart';
import 'package:tmed_kiosk/features/common/ticket/rele_d.dart';
import 'package:tmed_kiosk/features/common/ticket/row_title.dart';

class ReceiptRoll80 extends BaseReceiptWidget {
  final OrdersEntity data;
  final int vat;
  final String tashkilot;
  ReceiptRoll80({
    required this.data,
    required this.vat,
    required this.tashkilot,
  });
  // final image =
  //     pw.MemoryImage(File("assets/images/tmed_terminal.png").readAsBytesSync());
  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(right: 28),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // pw.Center(child: pw.Image(image)),
          pw.Container(
            padding: const pw.EdgeInsets.only(top: 8),
            alignment: Alignment.center,
            child: pw.Text(
              tashkilot,
              textAlign: TextAlign.center,
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          PdfLine(length: 37),
          pw.Container(
            alignment: Alignment.center,
            padding: const pw.EdgeInsets.symmetric(horizontal: 8),
            child: pw.Text(
              '------------',
              style: const pw.TextStyle(fontSize: 8),
              textAlign: TextAlign.center,
            ),
          ),
          RowTitle(title: "INN", subtitle: "---------"),
          RowTitle(
            title: "Kuni",
            subtitle: MyFunctions.parseDate(data.createDate),
          ),
          RowTitle(
            title: "Vaqti",
            subtitle: MyFunctions.getClockFormatSek(data.createDate),
          ),
          RowTitle(title: "Check", subtitle: data.number.toString()),
          RowTitle(
            title: "Kassir/Qabul qiluvchi",
            subtitle: "${data.creator.lastname} ${data.creator.name}",
          ),
          PdfLine(length: 37),
          if (data.products.isNotEmpty) ...[
            ...List.generate(
              data.products.length,
              (index) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 2),
                child: OfferColum(
                  product: data.products[index],
                  index: index,
                  vat: vat,
                ),
              ),
            ),
          ],
          if (data.totalCost != data.insertedValue ||
              MyFunctions.filterCupons(data.products) == null) ...[
            PdfLine(length: 37),
            RowTitle(
              title: "Jami narxi:",
              subtitle:
                  "${MyFunctions.getFormatCost(data.totalCost.toString())} UZS",
            ),
            RowTitle(
              title: "Chegirma:",
              subtitle: "-",
            ),
            if (MyFunctions.filterCupons(data.products) != null)
              RowTitle(
                title: "Kupon:",
                subtitle:
                    "${MyFunctions.filterCupons(data.products)!.name}(${MyFunctions.filterCupons(data.products)!.discount}%)",
              ),
            RowTitle(
              title: "To'langan summa:",
              subtitle:
                  "${MyFunctions.getFormatCost(data.insertedValue.toString())} UZS",
            ),
            PdfLine(length: 37),
            RowTitle(title: "Check raqami", subtitle: data.number.toString()),
            RowTitle(title: "Terminal ID", subtitle: " EP00000000000151"),
            RowTitle(title: "Fiskal belgi", subtitle: " 383703056421"),
            PdfLine(length: 37),
          ],
          if (data.totalCost == data.insertedValue ||
              MyFunctions.filterCupons(data.products) != null) ...[
            PdfLine(length: 26, line: "* "),
            pw.Center(
              child: pw.Text(
                "TMEDID: ${data.number}",
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            PdfLine(length: 26, line: "* "),
            pw.Container(
              height: 96,
              width: double.infinity,
              child: pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: [
                        pw.Text(
                          "${data.user.name} ${data.user.lastname}",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // pw.Text(
                        //   "MedID ${data.number}",
                        //   style: pw.TextStyle(
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        pw.Text(
                          data.user.region != null
                              ? data.user.region.toString()
                              : "",
                          style: const pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          MyFunctions.parseDate(data.user.birthdate),
                          style: const pw.TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ),
                  pw.Container(
                    margin: const pw.EdgeInsets.only(left: 12),
                    child: pw.BarcodeWidget(
                      data: data.qrCode,
                      barcode: pw.Barcode.qrCode(),
                      width: 84,
                      height: 84,
                    ),
                  ),
                ],
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(
                "Iltimos, shifokor eshigi oldida turmang, televizor paneli oldida navbat kuting! Uchrashuv paytida shifokorga QR kodini ko'rsating",
                style: const pw.TextStyle(fontSize: 10),
                textAlign: pw.TextAlign.center,
              ),
            ),
          ] else if (data.user.username.isNotEmpty &&
              data.totalCost != data.insertedValue) ...[
            pw.Container(
              height: 96,
              margin: const pw.EdgeInsets.only(top: 8),
              width: double.infinity,
              child: pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: [
                        pw.Text(
                          "${data.user.name} ${data.user.lastname}",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          "TMEDID ${data.number}",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          data.user.region != null
                              ? data.user.region.toString()
                              : "",
                          style: const pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          MyFunctions.parseDate(data.user.birthdate),
                          style: const pw.TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ),
                  pw.Container(
                    margin: const pw.EdgeInsets.only(left: 12),
                    child: pw.BarcodeWidget(
                      data: data.qrCode,
                      barcode: pw.Barcode.qrCode(),
                      width: 84,
                      height: 84,
                    ),
                  ),
                ],
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(
                "Iltimos, shifokor eshigi oldida turmang, televizor paneli oldida navbat kuting! Uchrashuv paytida shifokorga QR kodini ko'rsating",
                style: const pw.TextStyle(fontSize: 10),
                textAlign: pw.TextAlign.center,
              ),
            ),
          ] else
            pw.SizedBox(height: 20)
        ],
      ),
    );
  }

  @override
  Future<Uint8List> show() async {
    pw.Document pdf = pw.Document(version: PdfVersion.pdf_1_5);
    pdf.addPage(pw.Page(
      build: (context) => this,
      pageFormat: PdfPageFormat.roll80,
      theme: pw.ThemeData.withFont(
        bold: Font.ttf(await rootBundle.load("assets/fonts/NotoSans-Bold.ttf")),
        base: Font.ttf(
            await rootBundle.load("assets/fonts/NotoSans-Regular.ttf")),
        italic:
            Font.ttf(await rootBundle.load("assets/fonts/NotoSans-Italic.ttf")),
      ),
    ));
    return await pdf.save();
  }
}
