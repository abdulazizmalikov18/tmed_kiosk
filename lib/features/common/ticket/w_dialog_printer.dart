import 'dart:typed_data';

import 'package:tmed_kiosk/assets/colors/colors.dart';
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
      backgroundColor: backGroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: SizedBox(
        width: 250,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          children: [
            Expanded(
              child: Theme(
                data: ThemeData(primaryColor: contColor),
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
            const SizedBox(height: 16),
            FutureBuilder(
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
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: snapshot.data![index].isDefault ? blue : null,
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
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
