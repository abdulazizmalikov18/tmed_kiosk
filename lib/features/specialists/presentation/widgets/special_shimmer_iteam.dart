import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';

class SpecialShimmerIteam extends StatelessWidget {
  const SpecialShimmerIteam({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.color.contColor,
        boxShadow: wboxShadow,
        border: Border.all(color: white.withOpacity(.1)),
      ),
      padding: const EdgeInsets.all(12),
      child: Stack(
        children: [
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: Shimmer.fromColors(
          //     baseColor: grey.withOpacity(0.5),
          //     highlightColor: grey.withOpacity(0.16),
          //     child: Center(
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(98),
          //         child: Container(
          //           color: white,
          //           height: 98,
          //           width: 98,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Shimmer.fromColors(
              baseColor: blue.withOpacity(0.13),
              highlightColor: blue.withOpacity(0.01),
              child: Container(
                height: 72,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
