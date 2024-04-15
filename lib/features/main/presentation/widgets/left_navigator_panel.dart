// ignore_for_file: use_build_context_synchronously
// import 'dart:io';

// import 'package:flutter_barcode_sdk/dynamsoft_barcode.dart';
// import 'package:flutter_barcode_sdk/flutter_barcode_sdk.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/common/controllers/auth/authentication_bloc.dart';
// import 'package:tmed_kiosk/features/common/view/scanner_macos.dart';
// import 'package:tmed_kiosk/features/common/view/scanner_screen_windows.dart';
// import 'package:tmed_kiosk/features/common/view/scanner_screen_windows.dart';

// import 'package:tmed_kiosk/features/common/widgets/dialog_title.dart';
import 'package:tmed_kiosk/features/common/widgets/w_profile_dialog.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_barcode_sdk/dynamsoft_barcode.dart';
// import 'package:flutter_barcode_sdk/flutter_barcode_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmed_kiosk/features/specialists/presentation/controllers/bloc/specialists_bloc.dart';
import 'package:tmed_kiosk/main.dart';
import 'package:go_router/go_router.dart';

class LeftNavigatorPanel extends StatefulWidget {
  const LeftNavigatorPanel({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<LeftNavigatorPanel> createState() => _LeftNavigatorPanelState();
}

class _LeftNavigatorPanelState extends State<LeftNavigatorPanel> {
  // late FlutterBarcodeSdk _barcodeReader;
  // bool _isSDKLoaded = false;

  @override
  void initState() {
    super.initState();
    // initBarcodeSDK();
  }

  // Future<void> initBarcodeSDK() async {
  //   _barcodeReader = FlutterBarcodeSdk();
  //   await _barcodeReader.setLicense(
  //       'DLS2eyJoYW5kc2hha2VDb2RlIjoiMjAwMDAxLTE2NDk4Mjk3OTI2MzUiLCJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSIsInNlc3Npb25QYXNzd29yZCI6IndTcGR6Vm05WDJrcEQ5YUoifQ==');
  //   await _barcodeReader.init();
  //   await _barcodeReader.setBarcodeFormats(BarcodeFormat.ALL);
  //   setState(() {
  //     _isSDKLoaded = true;
  //   });
  // }

  List<String> list = [
    AppIcons.barCode,
    AppIcons.box,
    AppIcons.person,
    // AppIcons.bookMark,
    AppIcons.moneyRecive,
    AppIcons.map,
  ];

  void _onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: contColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
        gradient: RadialGradient(
          transform: GradientRotation(0.1),
          stops: [0.01, 10],
          center: Alignment.topLeft,
          radius: 1.1,
          colors: [
            Color(0xFF1A79FF),
            contColor,
          ],
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              _onTap(context, 4);
            },
            onDoubleTap: () {},
            child: Container(
              width: 80,
              height: 60,
              padding: const EdgeInsets.all(8),
              child: Image.asset($appType.logoImage),
            ),
          ),
          const Spacer(flex: 3),
          ...List.generate(
            list.length,
            (index) => GestureDetector(
              onDoubleTap: () {
                switch (widget.navigationShell.currentIndex) {
                  case 0:
                    context.read<GoodsBloc>().add(GetOrgProduct());
                    break;
                  case 1:
                    context.read<SpecialistsBloc>().add(GetSpecialists());
                    context.read<SpecialistsBloc>().add(GetSpeciaCats());
                    break;
                  case 2:
                    break;
                }
              },
              child: WScaleAnimation(
                onTap: () {
                  if (index == 0) {
                    // if (_isSDKLoaded == false) {
                    //   _showDialog('Error', 'Barcode SDK is not loaded.');
                    //   return;
                    // }
                    // if (Platform.isWindows) {
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) => AlertDialog(
                    //       contentPadding:
                    //           const EdgeInsets.fromLTRB(24, 12, 24, 24),
                    //       titlePadding:
                    //           const EdgeInsets.fromLTRB(24, 12, 24, 0),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(18),
                    //       ),
                    //       title: const DialogTitle(title: "Сканировать"),
                    //       content: ScannerScreenWindows(
                    //         barcodeReader: _barcodeReader,
                    //       ),
                    //     ),
                    //   );
                    // } else if (Platform.isMacOS) {
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) => const ScannerMacosDialog(),
                    //   );
                    // }
                  } else {
                    _onTap(context, index - 1);
                    if (index == 4) {}
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  width: double.infinity,
                  height: 56,
                  color: widget.navigationShell.currentIndex + 1 == index
                      ? blue.withOpacity(.2)
                      : null,
                  child: SvgPicture.asset(
                    list[index],
                    colorFilter:
                        widget.navigationShell.currentIndex + 1 != index
                            ? const ColorFilter.mode(white, BlendMode.srcIn)
                            : const ColorFilter.mode(blue, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(flex: 4),
          WScaleAnimation(
            onTap: () {
              showDialog(
                context: context,
                barrierColor: Colors.black45,
                builder: (ctx) {
                  return ProfileSettingsDialog(
                    parentContext: context,
                  );
                },
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return Container(
                    height: 40,
                    width: 40,
                    color: greyText,
                    child: state.listSpecial.isNotEmpty
                        ? Image.network(
                            state.listSpecial.first.avatar,
                            fit: BoxFit.cover,
                            errorBuilder: (context, url, error) =>
                                const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.person, color: white),
                            ),
                          )
                        : Image.network(
                            state.user.avatar,
                            fit: BoxFit.cover,
                            errorBuilder: (context, url, error) =>
                                const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.person, color: white),
                            ),
                          ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
