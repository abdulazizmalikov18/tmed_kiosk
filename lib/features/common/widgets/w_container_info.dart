import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:flutter/cupertino.dart';

class WContainer2 extends StatefulWidget {
  const WContainer2({
    super.key,
    this.child,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.gradient,
    this.radius,
    this.shadow,
    this.isShadow = true,
    this.padding,
    this.borderColor,
    this.borderWidth,
  });

  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color? color;
  final Gradient? gradient;
  final double? radius;
  final List<BoxShadow>? shadow;
  final EdgeInsets? padding;
  final Color? borderColor;
  final double? borderWidth;
  final bool isShadow;
  @override
  State<WContainer2> createState() => _WContainer2State();
}

class _WContainer2State extends State<WContainer2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              width: widget.borderWidth ?? 0,
              color: widget.borderColor ?? white),
          borderRadius: BorderRadius.circular(8),
          color: widget.color,
          gradient: widget.gradient,
          boxShadow: widget.isShadow
              ? widget.shadow ??
                  [
                    const BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 10,
                      spreadRadius: 0,
                      color: Color.fromRGBO(38, 38, 38, 0.10),
                    ),
                  ]
              : null),
      height: widget.height,
      width: widget.width,
      padding: const EdgeInsets.all(10),
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 6),
      child: widget.child,
    );
  }
}
