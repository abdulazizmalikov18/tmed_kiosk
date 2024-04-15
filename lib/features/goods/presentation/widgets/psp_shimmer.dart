import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:shimmer/shimmer.dart';

class PspShimmer extends StatelessWidget {
  const PspShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: wboxShadow,
        color: contColor,
      ),
      width: MediaQuery.of(context).size.width - 64,
      padding: const EdgeInsets.all(12),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Shimmer.fromColors(
              baseColor: blue.withOpacity(0.13),
              highlightColor: blue.withOpacity(0.01),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(114),
                  color: blue,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Shimmer.fromColors(
              baseColor: blue.withOpacity(0.13),
              highlightColor: blue.withOpacity(0.01),
              child: Container(
                width: MediaQuery.of(context).size.width - 140,
                height: 140,
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
