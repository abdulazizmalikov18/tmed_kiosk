import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:flutter/material.dart';

class TimeWidget extends StatelessWidget {
  const TimeWidget({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) =>
            Center(
          child: Text(
            MyFunctions.getformCloc(DateTime.now().toString()),
            style: AppTheme.bodyMedium.copyWith(color: white, fontSize: 32),
          ),
        ),
      );
}
