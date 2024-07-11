import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/common/navigation/routs_contact.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';

Future<T?> openTimer<T>(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return const WCallTimerDialog();
      });
}

/// Call TV Dialog
class WCallTimerDialog extends StatefulWidget {
  const WCallTimerDialog({
    super.key,
  });

  @override
  State<WCallTimerDialog> createState() => _WCallTimerDialogState();
}

class _WCallTimerDialogState extends State<WCallTimerDialog>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    );

    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.color.contColor,
      surfaceTintColor: context.color.contColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.27),
        width: MediaQuery.of(context).size.width * 0.54,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/anim/timer2.json',
                      fit: BoxFit.cover,
                      height: 150
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  /// Call TV Button
                  WButton(
                    height: 56,
                    onTap: () {
                     const timer = Duration(seconds: 0);
                      if(timer == 0) {
                        context.go(RoutsContact.infoView);
                      }
                    },
                    borderRadius: 12,
                    color: blue,
                    text: "yes".tr(),
                    textStyle: AppTheme.displaySmall.copyWith(
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),

                  WButton(
                    height: 56,
                    border: Border.all(style: BorderStyle.none),
                    onTap: () {
                      // context.pop();
                      Navigator.pop(context);
                    },
                    color: red,
                    borderRadius: 12,
                    text: "no".tr(),
                    textStyle: AppTheme.displaySmall.copyWith(
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: WButton(
                  width: 24,
                  height: 24,
                  onTap: () {
                    context.pop();
                  },
                  color: Colors.transparent,
                  margin: const EdgeInsets.only(top: 8),
                  child: AppIcons.closeCircle
                      .svg(width: 24, height: 24, color: greyText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
