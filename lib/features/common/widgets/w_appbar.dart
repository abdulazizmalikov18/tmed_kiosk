import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/common/controllers/internet_bloc/internet_bloc.dart';
import 'package:tmed_kiosk/features/common/widgets/w_scale_animation.dart';
import 'package:tmed_kiosk/features/common/widgets/z_text_form_field.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
// import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class WAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WAppBar({
    super.key,
    this.onTapRow,
    this.onTabFilter,
    this.rowIcon = false,
    this.controller,
    this.searchController,
    this.isDrop = false,
    this.filter = 3,
    this.isDate = false,
    required this.onChanged,
    this.child,
  });
  final VoidCallback? onTapRow;
  final VoidCallback? onTabFilter;
  final bool rowIcon;
  final int filter;
  final TextEditingController? controller;
  final TextEditingController? searchController;
  final bool isDrop;
  final bool isDate;
  final Widget? child;
  final Function(String) onChanged;

  @override
  Size get preferredSize => Size.fromHeight(child == null ? 64 : 120);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetBloc, InternetState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                boxShadow: wboxShadow,
                color: context.color.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: AppBar(
                backgroundColor: context.color.backGroundColor,
                titleSpacing: 0,
                centerTitle: false,
                title: Container(
                  height: 48,
                  constraints: const BoxConstraints(maxWidth: 300),
                  margin: const EdgeInsets.only(left: 16),
                  child: ZTextFormField(
                    fillColor: context.color.whiteBlack,
                    onChanged: onChanged,
                    controller: searchController,
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: AppIcons.search.svg(color: white50),
                    ),
                    hintText: LocaleKeys.adduser_search.tr(),
                    hintTextStyle: const TextStyle(color: greyText),
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: greyText,
                  ),
                ),
                shadowColor: const Color.fromRGBO(38, 38, 38, 0.10),
                actions: [
                  if (onTabFilter != null)
                    WScaleAnimation(
                      onTap: onTabFilter!,
                      child: Container(
                        width: 48,
                        margin: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.color.contColor,
                          boxShadow: wboxShadow,
                          border: Border.all(color:  context.color.white.withOpacity(.1)),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.filterRemove,
                          colorFilter: filter == 2
                              ? const ColorFilter.mode(
                                  greyText, BlendMode.srcIn)
                              : null,
                        ),
                      ),
                    ),
                  if (onTapRow != null)
                    WScaleAnimation(
                      onTap: onTapRow!,
                      child: Container(
                        width: 48,
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.color.contColor,
                          border: Border.all(
                            color: context.color.white.withOpacity(.1),
                          ),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.rowVertical,
                          colorFilter: rowIcon
                              ? null
                              : const ColorFilter.mode(
                                  greyText, BlendMode.srcIn),
                        ),
                      ),
                    ),
                ],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
              ),
            ),
            if (child != null) Container(child: child)
          ],
        );
      },
    );
  }
}
