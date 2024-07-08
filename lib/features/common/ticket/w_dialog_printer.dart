import 'dart:io';
import 'dart:typed_data';

import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class PrinterDialog extends StatefulWidget {
  final Uint8List data;

  const PrinterDialog({super.key, required this.data});

  @override
  State<PrinterDialog> createState() => _PrinterDialogState();
}

class _PrinterDialogState extends State<PrinterDialog> {
  Printer? printer;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.color.backGroundColor,
      insetPadding: Platform.isIOS || Platform.isAndroid
          ? const EdgeInsets.all(16)
          : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: SizedBox(
        width: Platform.isIOS || Platform.isAndroid
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * 0.6,
        height: Platform.isIOS || Platform.isAndroid
            ? MediaQuery.of(context).size.height * 0.6
            : MediaQuery.of(context).size.height * 0.8,
        child: Platform.isIOS || Platform.isAndroid
            ? SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Theme(
                  data: ThemeData(primaryColor: context.color.contColor),
                  child: PdfPreview(
                    build: (format) => widget.data,
                    canChangeOrientation: false,
                    canDebug: false,
                    allowSharing: true,
                    allowPrinting: true,
                    canChangePageFormat: true,
                    padding: EdgeInsets.zero,
                    previewPageMargin: EdgeInsets.zero,
                  ),
                ),
              )
            : Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Theme(
                      data: ThemeData(primaryColor: context.color.contColor),
                      child: PdfPreview(
                        build: (format) => widget.data,
                        canChangeOrientation: false,
                        canDebug: false,
                        allowSharing: true,
                        allowPrinting: true,
                        canChangePageFormat: true,
                        padding: EdgeInsets.zero,
                        previewPageMargin: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FutureBuilder(
                      future: Printing.listPrinters(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () async {
                                await Printing.directPrintPdf(
                                  usePrinterSettings: true,
                                  format: PdfPageFormat.roll80,
                                  printer: snapshot.data![index],
                                  onLayout: (PdfPageFormat format) {
                                    return widget.data;
                                  },
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: snapshot.data![index].isDefault
                                      ? blue
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data![index].name,
                                    style: const TextStyle(color: white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
