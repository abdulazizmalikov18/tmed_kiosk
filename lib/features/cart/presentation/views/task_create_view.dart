import 'dart:io';

import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/constants/icons.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/task_create_model.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';
import 'package:tmed_kiosk/features/main/presentation/controllers/bloc/navigator_bloc.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCreateView extends StatefulWidget {
  const TaskCreateView({super.key, required this.vm, this.isPhone = false});
  final CartViewModel vm;
  final bool isPhone;

  @override
  State<TaskCreateView> createState() => _TaskCreateViewState();
}

class _TaskCreateViewState extends State<TaskCreateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isPhone ? null : contColor,
      appBar: widget.isPhone ? AppBar(title: const Text("Task")) : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            WTextField(
              onChanged: (value) {},
              hintText: "Comment",
              height: 128,
              maxLines: 6,
              controller: widget.vm.controllerComment,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              hintStyle: AppTheme.displayLarge,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: wdecoration2,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Check list"),
                  Divider(
                    color: white.withOpacity(.1),
                    height: 24,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: wdecoration3,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              alignment: Alignment.center,
                              child: TextField(
                                maxLines: 1,
                                controller: widget.vm.task[index].controller,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: wdecoration3,
                            child: AppIcons.tag.svg(),
                          ),
                          const SizedBox(width: 12),
                          InkWell(
                            onTap: () {
                              DateTime dateTime2 =
                                  widget.vm.task[index].dateTime;
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  contentPadding: const EdgeInsets.all(0),
                                  content: SizedBox(
                                    height: 200,
                                    child: CupertinoDatePicker(
                                      initialDateTime:
                                          widget.vm.task[index].dateTime,
                                      use24hFormat: true,
                                      mode: CupertinoDatePickerMode.dateAndTime,
                                      onDateTimeChanged: (value) {
                                        setState(() {
                                          dateTime2 = value;
                                        });
                                      },
                                    ),
                                  ),
                                  actions: [
                                    WButton(
                                      onTap: () {
                                        Navigator.pop(context);
                                        widget.vm.task[index].dateTime =
                                            dateTime2;
                                        setState(() {});
                                      },
                                      text: "Save",
                                    )
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              padding: const EdgeInsets.all(8),
                              decoration: wdecoration3.copyWith(
                                color: widget.vm.task[index].dateTime.day !=
                                            DateTime.now().day ||
                                        widget.vm.task[index].dateTime.hour !=
                                            DateTime.now().hour
                                    ? blue.withOpacity(.2)
                                    : null,
                                border: widget.vm.task[index].dateTime.day !=
                                            DateTime.now().day ||
                                        widget.vm.task[index].dateTime.hour !=
                                            DateTime.now().hour
                                    ? Border.all(
                                        width: 0, color: Colors.transparent)
                                    : null,
                              ),
                              child: AppIcons.calendar.svg(
                                color: widget.vm.task[index].dateTime.day !=
                                            DateTime.now().day ||
                                        widget.vm.task[index].dateTime.hour !=
                                            DateTime.now().hour
                                    ? blue
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          InkWell(
                            onTap: () {
                              widget.vm.task.removeAt(index);
                              setState(() {});
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: red.withOpacity(.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: AppIcons.delate.svg(),
                            ),
                          )
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemCount: widget.vm.task.length,
                  ),
                  if (widget.vm.task.isNotEmpty) const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      widget.vm.task.add(TaskCreateModel(
                        index: widget.vm.task.length,
                        controller: TextEditingController(),
                        dateTime: DateTime.now(),
                      ));
                      setState(() {});
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcons.addCircle.svg(
                            color: white.withOpacity(.5),
                            height: 18,
                            width: 18),
                        const SizedBox(width: 4),
                        Text(
                          "Vazifa qo’shish",
                          style: AppTheme.bodyLarge.copyWith(
                              fontWeight: FontWeight.w400,
                              color: white.withOpacity(.5)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: WButton(
                onTap: () {
                  if (Platform.isWindows || Platform.isMacOS) {
                    context.read<MyNavigatorBloc>().add(NavId(0));
                  } else {
                    Navigator.pop(context);
                  }
                },
                text: LocaleKeys.cartOrderCancelButton.tr(),
                color: red,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: WButton(
                onTap: () {
                  if (Platform.isWindows || Platform.isMacOS) {
                    context.read<MyNavigatorBloc>().add(NavId(0));
                  } else {
                    Navigator.pop(context);
                  }
                },
                text: LocaleKeys.adduserSave.tr(),
                color: green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
