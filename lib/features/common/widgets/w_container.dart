import 'package:flutter/cupertino.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';

class WContainer extends StatefulWidget {
  const WContainer({
    super.key,
    required this.child,
    this.margin,
    this.width,
    this.height,
    this.padding,
    this.alignment,
  });
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;

  @override
  State<WContainer> createState() => _WContainerState();
}

class _WContainerState extends State<WContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: white.withOpacity(.1)),
        boxShadow: wboxShadow,
      ),
      height: widget.height,
      width: widget.width,
      alignment: widget.alignment,
      padding: widget.padding ?? const EdgeInsets.all(10),
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 6),
      child: widget.child,
    );
  }
}
