import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: Center(
        child: Container(
          width: 368,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: white,
            boxShadow: wboxShadow,
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppIcons.noData,
                height: 262,
                width: 320,
              ),
              const SizedBox(height: 12),
              const Text(
                'Hech narsa topilmadi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: dark,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Rahbariyatga murojaat qiling',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.5,
                  color: greyText,
                ),
              ),
              const SizedBox(height: 12),
              WButton(
                onTap: () {},
                text: "Refresh",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
