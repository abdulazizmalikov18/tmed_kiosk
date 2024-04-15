import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

class CreateOrderBottom extends StatelessWidget {
  const CreateOrderBottom({
    super.key,
    required this.onTapLeft,
    required this.onTapRight,
    required this.status,
  });
  final VoidCallback onTapLeft;
  final VoidCallback onTapRight;
  final FormzSubmissionStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      decoration: BoxDecoration(
        color: contColor,
        boxShadow: wboxShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: WButton(
              onTap: onTapLeft,
              text: LocaleKeys.adduserMoveToOrder.tr(),
              color: green,
              isLoading: status.isInProgress,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: WButton(
              onTap: onTapRight,
              text: LocaleKeys.checkPaymentButton.tr(),
            ),
          )
        ],
      ),
    );
  }
}
