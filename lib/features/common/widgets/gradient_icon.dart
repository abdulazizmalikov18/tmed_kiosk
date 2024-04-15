import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class GradientIcon extends StatelessWidget {
  final String iconName;
  final double size;
  const GradientIcon({
    super.key,
    this.size = 18,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const RadialGradient(
          center: Alignment.topLeft,
          radius: 2,
          colors: [blue, blue],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: SvgPicture.asset(
        iconName,
        height: size,
        width: size,
        colorFilter: const ColorFilter.mode(white, BlendMode.srcIn),
      ),
    );
  }
}
