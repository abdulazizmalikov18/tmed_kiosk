import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:shimmer/shimmer.dart';

class SuppliesShimmer extends StatelessWidget {
  const SuppliesShimmer({super.key, this.isPhone = false});
  final bool isPhone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: wboxShadow,
        color: white,
      ),
      width: 120,
      height: 48,
      margin: isPhone
          ? const EdgeInsets.fromLTRB(8, 0, 12, 24)
          : const EdgeInsets.fromLTRB(8, 0, 8, 8),
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
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
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
