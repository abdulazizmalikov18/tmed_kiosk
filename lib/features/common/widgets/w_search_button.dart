import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import '../../../../assets/constants/icons.dart';

class WSearchButton extends StatefulWidget {
  const WSearchButton({
    super.key,
    required this.onEditingComplete,
    required this.controller,
    required this.onChanged,
  });
  final Function() onEditingComplete;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  State<WSearchButton> createState() => _WSearchButtonState();
}

class _WSearchButtonState extends State<WSearchButton> {
  bool isTextShow = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 44,
      width: (isTextShow ? MediaQuery.sizeOf(context).height * 0.32 : 40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: widget.controller.text.isEmpty ? context.color.white.withOpacity(0.1) : blue,
        ),
      ),
      padding: isTextShow
          ? const EdgeInsets.symmetric(horizontal: 8)
          : const EdgeInsets.all(0),
      duration: const Duration(milliseconds: 200),
      child: Row(
        children: [
          if (isTextShow)
            Expanded(
              child: SearchTextField(
                controller: widget.controller,
                isActive: isTextShow,
                onEditingComplete: () {
                  widget.onEditingComplete();
                },
                onChanged: widget.onChanged,
              ),
            ),
          const SizedBox(width: 8),
          WButton(
            width: 24,
            height: 24,
            color: Colors.transparent,
            onTap: () => setState(() {
              if (widget.controller.text.isEmpty && isTextShow) {
                widget.onEditingComplete();
              }
              isTextShow = !isTextShow;
            }),
            child: AppIcons.search.svg(color: greyText),
          )
        ],
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final bool isActive;
  final void Function() onEditingComplete;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchTextField({
    super.key,
    required this.isActive,
    required this.onEditingComplete,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 44,
      duration: const Duration(milliseconds: 200),
      child: TextField(
        autofocus: true,
        style: TextStyle(color: context.color.white),
        controller: controller,
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 15),
          hintText: LocaleKeys.adduser_search.tr(),
          filled: true,
          fillColor: Colors.transparent,
          hintStyle: TextStyle(color: context.color.white.withOpacity(0.3)),
          border: const UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
