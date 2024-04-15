import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
import 'package:tmed_kiosk/features/common/entity/orders_entity.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/features/common/ticket/recept_roll_80.dart';
import 'package:tmed_kiosk/features/common/ticket/tickets/recept_roll_80_avans.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class GetPrinterDialog extends StatefulWidget {
  const GetPrinterDialog({
    super.key,
    required this.ordersEntity,
    required this.isAvans,
  });
  final OrdersEntity ordersEntity;
  final bool isAvans;

  @override
  State<GetPrinterDialog> createState() => _GetPrinterDialogState();
}

class _GetPrinterDialogState extends State<GetPrinterDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      constraints: const BoxConstraints(maxHeight: 400),
      child: FutureBuilder(
        future: Printing.listPrinters(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) => WButton(
                onTap: () async {
                  final tashkilot = context
                      .read<AuthenticationBloc>()
                      .state
                      .listSpecial
                      .where((element) =>
                          element.id ==
                          StorageRepository.getString(StorageKeys.SPID))
                      .first
                      .org
                      .name;
                  final data = widget.isAvans
                      ? await ReceiptRoll80Avans(
                              data: widget.ordersEntity,
                              vat: 0,
                              tashkilot: tashkilot)
                          .show()
                      : await ReceiptRoll80(
                              data: widget.ordersEntity,
                              vat: 0,
                              tashkilot: tashkilot)
                          .show();
                  await Printing.directPrintPdf(
                    usePrinterSettings: true,
                    format: PdfPageFormat.roll80,
                    printer: snapshot.data![index],
                    onLayout: (layout) {
                      return data;
                    },
                  );
                  Navigator.of(context).pop();
                },
                text: snapshot.data![index].name,
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
