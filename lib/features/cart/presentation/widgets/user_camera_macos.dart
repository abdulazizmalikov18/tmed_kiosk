// ignore_for_file: use_build_context_synchronously, library_prefixes

import 'dart:io';

import 'package:camera_macos/camera_macos.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/common/controllers/show_pop_up/show_pop_up_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as pathJoiner;
import 'package:path_provider/path_provider.dart';

/// Macos Camera

class WCameraDialogMacos extends StatefulWidget {
  const WCameraDialogMacos({super.key});

  @override
  State<WCameraDialogMacos> createState() => _WCameraDialogMacosState();
}

class _WCameraDialogMacosState extends State<WCameraDialogMacos> {
  final GlobalKey cameraKey = GlobalKey(debugLabel: "cameraKey");
  late CameraMacOSController macOSController;
  Uint8List? lastImagePreviewData;
  File? lastPictureTaken;
  PictureFormat selectedPictureFormat = PictureFormat.tiff;
  Future<String> get imageFilePath async => pathJoiner.join(
      (await getApplicationDocumentsDirectory()).path,
      "P_${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}_${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}.${selectedPictureFormat.name.replaceAll("PictureFormat.", "")}");

  @override
  void dispose() {
    macOSController.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: contColor,
      surfaceTintColor: contColor,
      child: SizedBox(
        width: 620,
        height: 480,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Transform.flip(
                  flipX: true,
                  child: CameraMacOSView(
                    key: cameraKey,
                    fit: BoxFit.fill,
                    cameraMode: CameraMacOSMode.photo,
                    onCameraInizialized: (CameraMacOSController controller) {
                      setState(() {
                        macOSController = controller;
                      });
                    },
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.9, -0.9),
                child: WButton(
                  width: 24,
                  height: 24,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  color: Colors.transparent,
                  padding: EdgeInsets.zero,
                  child: AppIcons.closeCircle
                      .svg(width: 24, height: 24, color: Colors.white),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: WButton(
                  onTap: () async {
                    CameraMacOSFile? imageData =
                        await macOSController.takePicture();
                    if (imageData != null) {
                      setState(() {
                        lastImagePreviewData = imageData.bytes;
                        savePicture(lastImagePreviewData!);
                      });
                    }
                  },
                  text: "Camera",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> savePicture(Uint8List photoBytes) async {
    try {
      String filename = await imageFilePath;
      File f = File(filename);
      if (f.existsSync()) {
        f.deleteSync(recursive: true);
      }
      f.createSync(recursive: true);
      f.writeAsBytesSync(photoBytes);
      lastPictureTaken = f;
      Navigator.of(context).pop(lastPictureTaken);
    } catch (e) {
      context
          .read<ShowPopUpBloc>()
          .add(ShowPopUp(message: e.toString(), status: PopStatus.error));
    }
  }
}
