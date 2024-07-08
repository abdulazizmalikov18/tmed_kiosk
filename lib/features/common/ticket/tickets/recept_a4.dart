// import 'dart:io';

import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/common/entity/orders_entity.dart';
import 'package:tmed_kiosk/features/common/ticket/offer_colum_a4.dart';
import 'package:tmed_kiosk/features/common/ticket/offer_colum_title_a4.dart';
import 'package:tmed_kiosk/features/common/ticket/row_title_2.dart';
import 'package:tmed_kiosk/features/common/ticket/row_title_3.dart';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import 'package:tmed_kiosk/features/common/ticket/base_receipt_widget.dart';
import 'package:tmed_kiosk/features/common/ticket/rele_d.dart';

class ReceiptA4 extends BaseReceiptWidget {
  final OrdersEntity data;
  final int vat;
  final String tashkilot;
  ReceiptA4({
    required this.data,
    required this.vat,
    required this.tashkilot,
  });
  // final image =
  //     pw.MemoryImage(File("assets/images/tmed_terminal.png").readAsBytesSync());
  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // pw.Center(child: pw.Image(image)),
        pw.Container(
          padding: const pw.EdgeInsets.only(top: 8, bottom: 12),
          alignment: Alignment.center,
          child: pw.Text(
            tashkilot,
            textAlign: TextAlign.center,
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        RowTitle2(
          title1: "Yaratish sanasi",
          title2: MyFunctions.getClockFormatSek(data.createDate),
          title3: "Savdo agenti",
          title4: "${data.creator.lastname} ${data.creator.name}",
        ),
        RowTitle2(
          title1: "Buyurtma raqami",
          title2: data.number.toString(),
          title3: "Adress",
          title4: data.user.region,
        ),
        RowTitle2(
          title1: "Izoh",
          title2: data.clientComment,
          title3: "Telefon",
          title4: "+998 (99) 999 99 99",
        ),
        RowTitle2(
          title1: "",
          title2: "",
          title3: "Bog’lanish uchun",
          title4: "${data.user.lastname} ${data.user.name}",
        ),
        PdfLine(length: 121),
        if (data.products.isNotEmpty) ...[
          OfferColumTitleA4(
            title1: "№",
            title2: "Dori vositasi",
            title3: "Seriya",
            title4: "Soni",
            title5: "O’lch.bir",
            title6: "Narxi",
            title7: "QQS",
            title8: "QQS narxi bilan",
          ),
          ...List.generate(
            data.products.length,
            (index) => OfferColumA4(
              product: data.products[index],
              index: index,
              vat: vat,
            ),
          ),
        ],

        RowTitle3(
          title: "Jami narxi",
          subtitle:
              "${MyFunctions.getFormatCost(data.totalCost.toString())} UZS",
        ),
        RowTitle3(title: "Chegirma", subtitle: "0,00"),
        if (MyFunctions.filterCupons(data.products) != null)
          RowTitle3(
            title: "Kupons",
            subtitle:
                "${MyFunctions.filterCupons(data.products)!.name}(${MyFunctions.filterCupons(data.products)!.discount}%)",
          ),
        RowTitle3(title: "Bonus summasi", subtitle: "0,00"),
        RowTitle3(
          title: "To’lovga",
          subtitle:
              "${MyFunctions.getFormatCost(data.insertedValue.toString())} UZS",
        ),
        if (data.user.username.isNotEmpty) ...[
          pw.Container(
            height: 96,
            margin: const pw.EdgeInsets.only(top: 12),
            width: double.infinity,
            child: pw.Row(
              children: [
                pw.Container(
                  margin: const pw.EdgeInsets.only(right: 12),
                  child: pw.BarcodeWidget(
                    data: data.qrCode,
                    barcode: pw.Barcode.qrCode(),
                    width: 84,
                    height: 84,
                  ),
                ),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "Tashkilot",
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      pw.Text(
                        "${data.user.name} ${data.user.lastname}",
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ] else
          pw.SizedBox(height: 20)
      ],
    );
  }

  @override
  Future<Uint8List> show() async {
    pw.Document pdf = pw.Document(version: PdfVersion.pdf_1_5);
    pdf.addPage(pw.Page(
      build: (context) => this,
      margin: const pw.EdgeInsets.all(16),
      pageFormat: PdfPageFormat.a4,
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
