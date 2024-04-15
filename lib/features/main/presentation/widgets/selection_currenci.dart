import 'package:flutter/material.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/w_list_selection.dart';

class SelectionCurrency extends StatelessWidget {
  const SelectionCurrency({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Valyutani tanlang'),
        const SizedBox(height: 24),
        WListSelection(
          onTap: () {
            _pageController.animateToPage(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          },
          title: 'UZB',
          isLenguage: true,
        ),
        const SizedBox(height: 24),
        WListSelection(
          onTap: () {
            _pageController.animateToPage(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          },
          title: 'Ruble',
          isLenguage: true,
        ),
        const SizedBox(height: 24),
        WListSelection(
          onTap: () {
            _pageController.animateToPage(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          },
          title: 'Dollar',
          isLenguage: true,
        ),
      ],
    );
  }
}
