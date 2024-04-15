import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class GetPrinterListDialog extends StatefulWidget {
  const GetPrinterListDialog({super.key, required this.onTap});
  final Function(Printer printer) onTap;

  @override
  State<GetPrinterListDialog> createState() => _GetPrinterListDialogState();
}

class _GetPrinterListDialogState extends State<GetPrinterListDialog> {
  List<Printer> printers = [];
  bool loading = true;
  getPrinter() async {
    printers = await Printing.listPrinters();
    Log.w(printers);
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    getPrinter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      constraints: const BoxConstraints(maxHeight: 400),
      child: Builder(
        builder: (context) {
          if (loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            itemCount: printers.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) => WButton(
              onTap: () {
                widget.onTap(printers[index]);
              },
              text: printers[index].name,
            ),
          );
        },
      ),
    );
  }
}
