import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';

class WTabBar extends StatelessWidget {
  final TabController? tabController;
  final List<Widget> tabs;
  final Function(int)? onTap;
  final EdgeInsetsGeometry? padding;

  const WTabBar({
    this.tabController,
    required this.tabs,
    super.key,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: wdecoration2,
      child: TabBar(
        dividerColor: Colors.transparent,
        padding: padding ?? const EdgeInsets.all(4),
        labelPadding: const EdgeInsets.all(4),
        indicator: ShapeDecoration(
          shadows: [
            BoxShadow(
                blurRadius: 1,
                offset: const Offset(0, 3),
                color: const Color(0xff000000).withOpacity(0.04)),
            BoxShadow(
                blurRadius: 8,
                offset: const Offset(0, 3),
                color: const Color(0xff000000).withOpacity(0.12)),
          ],
          shape: RoundedRectangleBorder(
            side: BorderSide(color: const Color(0xff000000).withOpacity(0.04)),
            borderRadius: BorderRadius.circular(8),
          ),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[blue, blue],
          ),
        ),
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        onTap: onTap,
        unselectedLabelStyle: Theme.of(context)
            .textTheme
            .displayLarge!
            .copyWith(fontSize: 13, fontWeight: FontWeight.w600),
        labelStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
        unselectedLabelColor: shuttleGrey,
        labelColor: white,
        tabs: tabs,
      ),
    );
  }
}
