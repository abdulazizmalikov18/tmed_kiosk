import 'package:tmed_kiosk/core/exceptions/context_extension.dart';
import 'package:tmed_kiosk/core/utils/enums.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';

class GenderDropDown extends StatefulWidget {
  const GenderDropDown({
    super.key,
    required this.controller,
    required this.onChange,
    required this.isDisebled,
  });
  final TextEditingController controller;
  final VoidCallback onChange;
  final bool isDisebled;

  @override
  State<GenderDropDown> createState() => _GenderDropDownState();
}

class _GenderDropDownState extends State<GenderDropDown> {
  late SampleItem selectedMenu;

  @override
  void initState() {
    if (widget.controller.text == 'f') {
      selectedMenu = SampleItem.ayol;
    } else {
      selectedMenu = SampleItem.er;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: widget.isDisebled
                ? () {}
                : () {
                    selectedMenu = SampleItem.er;
                    widget.controller.text = SampleItem.er.genderType;
                    widget.onChange();
                    setState(() {});
                  },
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.color.whiteBlack,
                border: Border.all(color: context.color.white.withOpacity(.1)),
              ),
              child: Row(
                children: [
                  Transform.scale(
                    scale: 1.5,
                    child: CupertinoCheckbox(
                      value: selectedMenu == SampleItem.er,
                      onChanged: (value) {
                        if (!widget.isDisebled) {
                          selectedMenu = SampleItem.er;
                          widget.controller.text = SampleItem.er.genderType;
                          widget.onChange();
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  Text(
                    LocaleKeys.adduser_gender_man.tr(),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: context.color.white.withOpacity(.5),
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: InkWell(
            onTap: widget.isDisebled
                ? () {}
                : () {
                    selectedMenu = SampleItem.ayol;
                    widget.controller.text = SampleItem.ayol.genderType;
                    widget.onChange();
                    setState(() {});
                  },
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.color.whiteBlack,
                border: Border.all(color: context.color.white.withOpacity(.1)),
              ),
              child: Row(
                children: [
                  Transform.scale(
                    scale: 1.5,
                    child: CupertinoCheckbox(
                      value: selectedMenu == SampleItem.ayol,
                      onChanged: (value) {
                        if (!widget.isDisebled) {
                          selectedMenu = SampleItem.ayol;
                          widget.controller.text = SampleItem.ayol.genderType;
                          widget.onChange();
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  Text(
                    LocaleKeys.adduser_gender_woman.tr(),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: context.color.white.withOpacity(.5),
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
