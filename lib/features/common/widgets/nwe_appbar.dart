import 'dart:io';

import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';

class NewAppBar extends StatefulWidget implements PreferredSizeWidget {
  const NewAppBar({
    super.key,
    required this.title,
    this.child,
    this.action = const [],
  });
  final String title;
  final Widget? child;
  final List<Widget> action;

  @override
  State<NewAppBar> createState() => _NewAppBarState();

  @override
  Size get preferredSize => Size(
        double.infinity,
        child == null
            ? SizeConfig.h(60)
            : Platform.isAndroid || Platform.isIOS
                ? SizeConfig.h(80)
                : SizeConfig.h(104),
      );
}

class _NewAppBarState extends State<NewAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.color.contColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style:
                    AppTheme.displaySmall.copyWith(fontWeight: FontWeight.w600,color: context.color.white),
              ),
              const Spacer(),
              ...widget.action
            ],
          ),
          if (widget.child != null)
            Container(
              height: SizeConfig.h(34),
              width: double.infinity,
              margin: const EdgeInsets.only(top: 12),
              child: widget.child,
            ),
        ],
      ),
    );
  }
}
