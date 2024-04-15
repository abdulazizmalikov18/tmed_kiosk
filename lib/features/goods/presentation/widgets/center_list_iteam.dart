import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';

class CenterListItem extends StatelessWidget {
  final double index;
  final bool isSelected;
  final bool isDouble;

  const CenterListItem({
    super.key,
    required this.index,
    required this.isSelected,
    this.isDouble = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? const Color.fromRGBO(127, 146, 160, 0.21) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isDouble ? "$index%" : "${index.toInt()}%",
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w400,
          color: isSelected ? white : const Color(0xFF7F92A0),
        ),
      ),
    );
  }
}
