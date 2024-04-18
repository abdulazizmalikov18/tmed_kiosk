import 'package:easy_localization/easy_localization.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/features/auth/domain/entity/flag_entity.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';

class DropDownFlag extends StatelessWidget {
  const DropDownFlag({
    super.key,
    this.radius,
    this.width,
    this.height,
    this.offset,
    this.color,
    this.addedText,
    required this.items,
    required this.selectedItem,
    required this.filterFunction,
    this.isFlag = false,
  });

  final double? height;
  final double? width;
  final double? radius;
  final ValueNotifier<FlagEntity?> selectedItem;
  final String? addedText;
  final Offset? offset;
  final Color? color;
  final List<FlagEntity> items;
  final Function() filterFunction;
  final bool isFlag;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      width: width ?? MediaQuery.of(context).size.width - 32,
      decoration: BoxDecoration(
        color: color ?? context.color.white.withOpacity(.1),
        borderRadius: BorderRadius.circular(radius ?? 8),
      ),
      child: ValueListenableBuilder(
        valueListenable: selectedItem,
        builder: (context, count, _) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: width ?? MediaQuery.of(context).size.width - 32,
            height: height ?? 40,
            alignment: Alignment.center,
            child: DropdownButton2(
              hint: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 26,
                    width: 26,
                    child: Image.asset(selectedItem.value!.icon),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    selectedItem.value!.name,
                    style: AppTheme.displayLarge.copyWith(color: context.color.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 250,
                width: width ?? MediaQuery.of(context).size.width - 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.color.white.withOpacity(.1),
                ),
                elevation: 0,
                offset: offset ?? const Offset(-17, -16),
                scrollbarTheme: const ScrollbarThemeData(
                  thickness: MaterialStatePropertyAll(0.5),
                ),
              ),
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: AppIcons.arrowDownB.svg(
                    height: 16,
                    width: 16,
                    color: context.color.white,
                  ),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(height: 40),
              items: items.map((item) {
                return DropdownMenuItem<FlagEntity>(
                  value: item,

                  enabled: false,
                  child: StatefulBuilder(
                    builder: (context, menuSetState) {
                      return InkWell(
                        onTap: () {
                          selectedItem.value = item;
                          // context.setLocale(Locale(
                          //     selectedItem.value!.name == "Uzbek"
                          //         ? 'uz'
                          //         : 'ru'));
                          Navigator.pop(context);
                          filterFunction();
                        },
                        child: Container(
                          height: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 26,
                                width: 26,
                                child: Image.asset(item.icon),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item.name,
                                style: AppTheme.displayLarge
                                    .copyWith(color: context.color.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
              isExpanded: true,
              onChanged: (value) {},
              underline: const SizedBox(),
            ),
          );
        },
      ),
    );
  }
}
