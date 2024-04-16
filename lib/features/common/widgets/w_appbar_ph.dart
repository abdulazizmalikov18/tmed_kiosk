import 'package:easy_localization/easy_localization.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/features/common/widgets/w_container.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';
import 'package:tmed_kiosk/features/main/presentation/widgets/phone_bar_scaner.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class WAppBarPhone extends StatelessWidget implements PreferredSizeWidget {
  const WAppBarPhone({
    super.key,
    required this.onChanged,
    this.child,
    required this.vmC,
    required this.isQrcode,
  });
  final Function(String) onChanged;
  final Widget? child;
  final CartViewModel vmC;
  final bool isQrcode;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: wboxShadow,
          border: Border.all(color: white.withOpacity(.1)),
        ),
        child: WTextField(
          inputDecoration: InputDecoration(
            border: InputBorder.none,
            hintText: LocaleKeys.adduser_search.tr(),
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 0, 12),
            prefixIconConstraints: const BoxConstraints(maxWidth: 40),
            prefixIcon: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppIcons.search),
            ),
          ),
          onChanged: onChanged,
          hintText: LocaleKeys.adduser_search.tr(),
        ),
      ),
      actions: [
        if (isQrcode)
          WScaleAnimation(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScannerPage(vm: vmC)));
            },
            child: WContainer(
              margin: const EdgeInsets.fromLTRB(0, 4, 16, 4),
              height: 44,
              width: 44,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(4),
              child: AppIcons.barCode.svg(
                color: white50,
                height: 26,
                width: 26,
              ),
            ),
          )
        else
          ...[]
      ],
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 48),
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 112);
}
