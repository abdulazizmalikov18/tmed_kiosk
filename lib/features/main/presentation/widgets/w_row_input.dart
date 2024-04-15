import 'package:tmed_kiosk/core/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';

class WRowInput extends StatelessWidget {
  const WRowInput({
    super.key,
    required this.image,
    this.keyboardType = TextInputType.number,
    required this.controller,
    required this.imNm,
    this.isnum = true,
    this.onChanged,
    required this.onTap,
    required this.onTapClose,
  });
  final bool image;
  final bool isnum;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String imNm;
  final Function(String)? onChanged;

  final VoidCallback onTap;
  final VoidCallback onTapClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: image
                ? Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Image.asset(
                      imNm,
                      height: 48,
                      alignment: Alignment.centerLeft,
                    ),
                  )
                : Text(
                    imNm,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: 48,
              decoration: wdecoration2,
              padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: controller.text.isNotEmpty
                      ? WScaleAnimation(
                          onTap: onTapClose,
                          child: const Icon(Icons.close_rounded),
                        )
                      : null,
                ),
                onTap: onTap,
                onChanged: onChanged,
                inputFormatters: isnum
                    ? [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly,
                        ThousandsFormatter(),
                      ]
                    : [],
                keyboardType: keyboardType,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WhitelistingTextInputFormatter {}
