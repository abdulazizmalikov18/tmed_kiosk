import 'dart:async';

import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/auth/presentation/widgets/input_helper.dart';
import 'package:tmed_kiosk/features/common/widgets/stroke_paint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef CaretMoved = void Function(Offset? globalCaretPosition);
typedef TextChanged = void Function(String text);

// Helper widget to track caret position.
class TrackingTextInput extends StatefulWidget {
  const TrackingTextInput({
    super.key,
    this.onCaretMoved,
    this.onTextChanged,
    this.hint,
    this.isObscured = false,
    this.height,
    this.isPhone = false,
    this.textInputAction,
    required this.controller,
    this.inputFormatters,
    this.onEditingComplete,
  });
  final CaretMoved? onCaretMoved;
  final TextChanged? onTextChanged;
  final String? hint;
  final bool isObscured;
  final double? height;
  final bool isPhone;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onEditingComplete;
  @override
  State<TrackingTextInput> createState() => _TrackingTextInputState();
}

class _TrackingTextInputState extends State<TrackingTextInput>
    with SingleTickerProviderStateMixin {
  final GlobalKey _fieldKey = GlobalKey();
  Timer? _debounceTimer;
  bool isObscure = false;
  late AnimationController animationController;
  double borderRadius = 16;

  @override
  initState() {
    if (widget.isPhone) {
      borderRadius = 8;
    }
    widget.controller.addListener(() {
      // We debounce the listener as sometimes the caret position is updated after the listener
      // this assures us we get an accurate caret position.
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        if (_fieldKey.currentContext != null) {
          // Find the render editable in the field.
          final RenderObject? fieldBox =
              _fieldKey.currentContext?.findRenderObject();
          var caretPosition =
              fieldBox is RenderBox ? getCaretPosition(fieldBox) : null;

          widget.onCaretMoved?.call(caretPosition);
        }
      });
      widget.onTextChanged?.call(widget.controller.text);
    });
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    animationController.forward();
    super.initState();
    isObscure = widget.isObscured;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: widget.isPhone ? 16 : 20,
            fontWeight: FontWeight.w400,
            color: white,
            letterSpacing: -0.48,
          ),
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction ?? TextInputAction.none,
      onEditingComplete: widget.onEditingComplete,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: white.withOpacity(.1), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: white.withOpacity(.1), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: blue, width: 2),
        ),
        hintText: widget.hint,
        hintStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontSize: widget.isPhone ? 16 : 20,
            fontWeight: FontWeight.w400,
            color: greyText,
            letterSpacing: -0.48),
        contentPadding: widget.isPhone
            ? const EdgeInsets.symmetric(vertical: 12, horizontal: 16)
            : const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        suffixIconConstraints: const BoxConstraints(maxWidth: 52),
        suffixIcon: !widget.isObscured
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(right: 24),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                    if (isObscure) {
                      animationController.forward();
                    } else {
                      animationController.reverse();
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: AnimatedBuilder(
                        animation: animationController,
                        child: SvgPicture.asset(AppIcons.eye),
                        builder: (context, child) => SizedBox(
                          width: 24,
                          height: 24,
                          child: CustomPaint(
                            foregroundPainter:
                                StrokePaint(animationController.value),
                            child: child,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        fillColor: contColor,
        filled: true,
        counterStyle:
            Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12),
      ),
      key: _fieldKey,
      controller: widget.controller,
      cursorColor: blue,
      obscureText: isObscure,
    );
  }
}
