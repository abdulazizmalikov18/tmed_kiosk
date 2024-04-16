import 'dart:io';

import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/common/models/kassa_special_model.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:tmed_kiosk/restart_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SelectionAccountDialog extends StatefulWidget {
  const SelectionAccountDialog({super.key, required this.listSpecial});

  final List<KassaSpecialModel> listSpecial;

  @override
  State<SelectionAccountDialog> createState() => _SelectionAccountDialogState();
}

class _SelectionAccountDialogState extends State<SelectionAccountDialog> {
  int actionIndex = 0;
  @override
  void initState() {
    actionIndex = widget.listSpecial.indexWhere((element) =>
        element.id == StorageRepository.getString(StorageKeys.SPID));
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: contColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Accountni tanlang',
                style: AppTheme.displayLarge.copyWith(fontSize: 20),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: AppIcons.closeCircle.svg(),
              )
            ],
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height / 2,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    actionIndex = index;
                    setState(() {});
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: actionIndex == index
                          ? blue.withOpacity(.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: actionIndex == index
                          ? null
                          : Border.all(color: borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              widget.listSpecial[index].avatar,
                              height: 48,
                              width: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.person,
                                color: grey,
                                size: 48,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.listSpecial[index].name} ${widget.listSpecial[index].lastname}",
                                  style: AppTheme.bodyLarge,
                                ),
                                Text(
                                  "${widget.listSpecial[index].job.name} * ${widget.listSpecial[index].org.name}",
                                  style: AppTheme.labelLarge,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          (actionIndex == index
                                  ? AppIcons.checkbox
                                  : AppIcons.checkboxNull)
                              .svg(),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: widget.listSpecial.length,
            ),
          ),
          const SizedBox(height: 28),
          WButton(
            margin: Platform.isIOS ? const EdgeInsets.only(bottom: 24) : null,
            onTap: () async {
              if (widget.listSpecial[actionIndex].id ==
                  StorageRepository.getString(StorageKeys.SPID)) return;
              await StorageRepository.putString(
                  StorageKeys.SPID, widget.listSpecial[actionIndex].id);
              StorageRepository.putString(StorageKeys.COMPID,
                      widget.listSpecial[actionIndex].org.slugName)!
                  .then(
                (value) => RestartWidget.restartApp(context),
              );
            },
            text: LocaleKeys.specialist_category.tr(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
