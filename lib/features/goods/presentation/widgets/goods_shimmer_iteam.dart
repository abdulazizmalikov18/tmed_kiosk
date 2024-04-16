import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';

class GoodsShimmerIteam extends StatelessWidget {
  const GoodsShimmerIteam({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.color.contColor,
        boxShadow: wboxShadow,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Shimmer.fromColors(
              baseColor: blue.withOpacity(0.13),
              highlightColor: blue.withOpacity(0.01),
              child: Container(
                width: 180,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: blue,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Shimmer.fromColors(
              baseColor: blue.withOpacity(0.13),
              highlightColor: blue.withOpacity(0.01),
              child: Container(
                height: 92,
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
