// // ignore_for_file: use_build_context_synchronously, library_prefixes

// import 'dart:convert';

// import 'package:camera_macos/camera_macos.dart';
// import 'package:tmed_kiosk/assets/colors/colors.dart';
// import 'package:tmed_kiosk/assets/constants/icons.dart';
// import 'package:tmed_kiosk/features/common/repo/log_service.dart';
// import 'package:tmed_kiosk/features/common/view/utils.dart';
// import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:flutter_barcode_sdk/dynamsoft_barcode.dart';
// // import 'package:flutter_barcode_sdk/flutter_barcode_sdk.dart';

// /// Macos Camera

// class ScannerMacosDialog extends StatefulWidget {
//   const ScannerMacosDialog({super.key});

//   @override
//   State<ScannerMacosDialog> createState() => _ScannerMacosDialogState();
// }

// class _ScannerMacosDialogState extends State<ScannerMacosDialog> {
//   final GlobalKey cameraKey = GlobalKey(debugLabel: "cameraKey");
//   late CameraMacOSController macOSController;
//   late FlutterBarcodeSdk _barcodeReader;
//   bool _isScanAvailable = true;
//   bool _isScanRunning = false;
//   String _platformVersion = 'Unknown';
//   String _barcodeResults = '';
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//     initBarcodeSDK();
//   }

//   @override
//   void dispose() {
//     macOSController.destroy();
//     super.dispose();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     String platformVersion;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       platformVersion = await FlutterBarcodeSdk.platformVersion;
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _platformVersion = platformVersion;
//     });
//   }

//   Future<void> initBarcodeSDK() async {
//     _barcodeReader = FlutterBarcodeSdk();
//     // Get 30-day FREEE trial license from https://www.dynamsoft.com/customer/license/trialLicense?product=dbr
//     await _barcodeReader.setLicense(
//         'DLS2eyJoYW5kc2hha2VDb2RlIjoiMjAwMDAxLTE2NDk4Mjk3OTI2MzUiLCJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSIsInNlc3Npb25QYXNzd29yZCI6IndTcGR6Vm05WDJrcEQ5YUoifQ==');
//     await _barcodeReader.init();
//     await _barcodeReader.setBarcodeFormats(BarcodeFormat.ALL);

//     // Get all current parameters.
//     // Refer to: https://www.dynamsoft.com/barcode-reader/parameters/reference/image-parameter/?ver=latest
//     String params = await _barcodeReader.getParameters();
//     // Convert parameters to a JSON object.
//     dynamic obj = json.decode(params);
//     // Modify parameters.
//     obj['ImageParameter']['DeblurLevel'] = 5;
//   }

//   void startVideo() async {
//     _isScanRunning = true;
//     await macOSController.startImageStream((availableImage) async {
//       int format = ImagePixelFormat.IPF_RGB_888.index;

//       if (!_isScanAvailable) {
//         return;
//       }

//       _isScanAvailable = false;
//       Log.w("NIma gap");
//       _barcodeReader
//           .decodeImageBuffer(availableImage.bytes, availableImage.width,
//               availableImage.height, availableImage.bytesPerRow, format)
//           .then((results) {
//         if (_isScanRunning) {
//           Log.w("_isScanRunning $_isScanRunning");
//           Log.w("results $results");
//           setState(() {
//             _barcodeResults = getBarcodeResults(results);
//           });
//         }

//         _isScanAvailable = true;
//       }).catchError((error) {
//         _isScanAvailable = false;
//       });
//     });
//   }

//   void stopVideo() async {
//     setState(() {
//       _barcodeResults = '';
//     });
//     _isScanRunning = false;
//     await macOSController.stopImageStream();
//   }

//   void videoScan() async {
//     if (!_isScanRunning) {
//       startVideo();
//     } else {
//       stopVideo();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: contColor,
//       surfaceTintColor: contColor,
//       child: SizedBox(
//         width: 620,
//         height: 480,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Transform.flip(
//                   flipX: true,
//                   child: CameraMacOSView(
//                     key: cameraKey,
//                     fit: BoxFit.fill,
//                     cameraMode: CameraMacOSMode.photo,
//                     onCameraInizialized: (CameraMacOSController controller) {
//                       setState(() {
//                         macOSController = controller;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: const Alignment(0.9, -0.9),
//                 child: WButton(
//                   width: 24,
//                   height: 24,
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   color: Colors.transparent,
//                   padding: EdgeInsets.zero,
//                   child: AppIcons.closeCircle
//                       .svg(width: 24, height: 24, color: Colors.white),
//                 ),
//               ),
//               SizedBox(
//                 height: 100,
//                 child: SingleChildScrollView(
//                   child: Text(
//                     _barcodeResults.isEmpty
//                         ? "NIMa gap $_platformVersion"
//                         : "$_barcodeResults $_platformVersion",
//                     style: const TextStyle(fontSize: 14, color: Colors.white),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 12,
//                 left: 12,
//                 right: 12,
//                 child: WButton(
//                   onTap: () {
//                     videoScan();
//                   },
//                   text: "Camera",
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
