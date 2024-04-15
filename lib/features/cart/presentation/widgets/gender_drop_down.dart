import 'package:tmed_kiosk/core/utils/enums.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
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
              padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
              decoration: wdecoration2,
              child: Row(
                children: [
                  CupertinoCheckbox(
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
                  Text(
                    LocaleKeys.adduserGenderMan.tr(),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: white.withOpacity(.5),
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
              padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
              decoration: wdecoration2,
              child: Row(
                children: [
                  CupertinoCheckbox(
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
                  Text(
                    LocaleKeys.adduserGenderWoman.tr(),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: white.withOpacity(.5),
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
