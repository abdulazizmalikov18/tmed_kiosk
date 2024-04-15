import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/widgets/cart_list_iteam_phone.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key, required this.vm});
  final CartViewModel vm;

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isMuted = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  playSound(sound) async {
    final player = AudioPlayer();
    if (isMuted) {
      Null;
    } else {
      await player.play(AssetSource(sound));
      Future.delayed(const Duration(milliseconds: 300), () {
        controller!.resumeCamera();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bar Code Scanner")),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 4,
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return state.cartMap.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        itemCount: state.cartMap.length,
                        itemBuilder: (context, index) => CartListIteamPhone(
                          index: index,
                          product: state
                              .cartMap[(state.cartMap.keys).toList()[index]]!,
                          vm: widget.vm,
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                      )
                    : const Center(child: Text('Scan a code'));
              },
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen(
      (scanData) => setState(() {
        result = scanData;
        controller.stopCamera();
        playSound("notif.mp3");
        context.read<GoodsBloc>().add(PrBarCode(
              result!.code ?? "",
              onSucces: (resaul) {
                context
                    .read<CartBloc>()
                    .add(CartAddMap(resaul, 0, isCart: true));
              },
              onError: (value) {
                context
                    .read<ShowPopUpBloc>()
                    .add(ShowPopUp(message: value, status: PopStatus.error));
              },
            ));
      }),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
