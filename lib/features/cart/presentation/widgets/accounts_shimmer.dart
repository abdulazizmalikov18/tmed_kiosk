import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:shimmer/shimmer.dart';

class AccountsShimmer extends StatelessWidget {
  const AccountsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72,
      padding: const EdgeInsets.all(12),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Shimmer.fromColors(
              baseColor: blue.withOpacity(0.13),
              highlightColor: blue.withOpacity(0.01),
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(48),
                  color: blue,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            top: 0,
            right: 0,
            left: 64,
            child: Shimmer.fromColors(
              baseColor: blue.withOpacity(0.13),
              highlightColor: blue.withOpacity(0.01),
              child: Container(
                height: 48,
                width: 300,
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
