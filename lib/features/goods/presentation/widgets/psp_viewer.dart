// import 'package:date_picker_timeline/date_picker_widget.dart';
import 'dart:io';

import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/common/widgets/time_gridview.dart';
import 'package:tmed_kiosk/features/goods/presentation/controllers/bloc/goods_bloc.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/psp_shimmer.dart';
import 'package:tmed_kiosk/features/goods/presentation/widgets/w_psp_iteam.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class PspViewer extends StatefulWidget {
  const PspViewer({
    super.key,
    this.dataIndex = -1,
    this.mydate,
    required this.onDateChange,
    required this.onChangePsp,
    required this.bloc,
  });
  final int? dataIndex;
  final DateTime? mydate;
  final Function(DateTime) onDateChange;
  final Function(int) onChangePsp;
  final GoodsBloc bloc;

  @override
  State<PspViewer> createState() => _PspViewerState();
}

class _PspViewerState extends State<PspViewer> {
  late int dataIndex;
  late DateTime mydate;
  bool weekDayEmpty = false;

  @override
  void initState() {
    dataIndex = widget.dataIndex ?? -1;
    mydate = widget.mydate ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoodsBloc, GoodsState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: state.status2.isInProgress ? 3 : state.psp.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  if (state.status2.isSuccess) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          dataIndex = index;
                        });
                        widget.onChangePsp(index);
                        if (state.psp[index].specialist.todayTimetable.startTime
                            .isNotEmpty) {
                          widget.bloc.add(
                              GetTimeTable(state.psp[index].specialist.id));
                        }
                      },
                      child: SizedBox(
                        width:
                            Platform.isMacOS || Platform.isWindows ? 300 : null,
                        child: WPSPIteam(
                          isSelect: dataIndex == index,
                          specialist: state.psp[index].specialist,
                        ),
                      ),
                    );
                  } else {
                    return const PspShimmer();
                  }
                },
              ),
            ),
            if (dataIndex >= 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Vazifa bajarish sanasini tanlang:'),
                          ),
                          SizedBox(width: 12),
                          // InkWell(
                          //   onTap: () => _selectDate(context),
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         MyFunctions.formattedDate(mydate),
                          //       ),
                          //       const SizedBox(width: 12),
                          //       SvgPicture.asset(
                          //         AppIcons.arrowDown,
                          //         colorFilter: const ColorFilter.mode(
                          //           white,
                          //           BlendMode.srcIn,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    if (!state.status3.isInProgress ||
                        state.timetable.isNotEmpty)
                      EasyDateTimeLine(
                        initialDate: DateTime.now(),
                        onDateChange: (selectedDate) {
                          mydate = selectedDate;
                          setState(() {});
                          weekDayEmpty = state.timetable
                              .where(
                                (element) =>
                                    MyFunctions.weekday(element.dayOfWeek) ==
                                    mydate.weekday,
                              )
                              .isEmpty;

                          widget.onDateChange(mydate);
                          if (!weekDayEmpty &&
                              state.psp[dataIndex].specialist.todayTimetable
                                  .startTime.isNotEmpty) {
                            widget.bloc.add(GetTimeDay(
                                state.psp[dataIndex].specialist.id, mydate));
                          }
                        },
                        activeColor: blue,
                        headerProps: const EasyHeaderProps(
                          monthStyle: AppTheme.bodyLarge,
                          selectedDateStyle: AppTheme.bodyLarge,
                          padding: EdgeInsets.zero,
                          monthPickerType: MonthPickerType.switcher,
                          dateFormatter: DateFormatter.fullDateMonthAsStrDY(),
                        ),
                        dayProps: EasyDayProps(
                          todayHighlightStyle:
                              TodayHighlightStyle.withBackground,
                          todayHighlightColor: blue.withOpacity(.5),
                          borderColor: borderColor,
                          todayStyle: DayStyle(
                            dayNumStyle: AppTheme.bodyLarge,
                            dayStrStyle:
                                AppTheme.labelLarge.copyWith(color: white),
                            monthStrStyle:
                                AppTheme.labelLarge.copyWith(color: white),
                          ),
                          inactiveDayStyle: DayStyle(
                            monthStrStyle:
                                AppTheme.labelLarge.copyWith(color: white),
                            dayStrStyle:
                                AppTheme.labelLarge.copyWith(color: white),
                            dayNumStyle: AppTheme.bodyLarge,
                          ),
                        ),
                      ),
                    if (state.psp[dataIndex].specialist.todayTimetable.startTime
                        .isNotEmpty)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text("Vazifa bajarish vaqti"),
                          ),
                          if (state.status3.isInProgress)
                            const Center(child: CircularProgressIndicator())
                          else if (!state.status3.isInProgress && !weekDayEmpty)
                            TimeGridView(
                              startTime: TimeOfDay(
                                hour: mydate.day == DateTime.now().day &&
                                        mydate.month == DateTime.now().month &&
                                        mydate.year == DateTime.now().year
                                    ? DateTime.now().hour
                                    : int.parse(
                                        state.psp[dataIndex].specialist
                                            .todayTimetable.startTime
                                            .substring(0, 2),
                                      ),
                                minute: 0,
                              ),
                              endTime: TimeOfDay(
                                hour: int.parse(state.psp[dataIndex].specialist
                                    .todayTimetable.endTime
                                    .substring(0, 2)),
                                minute: 0,
                              ),
                              dateTime: mydate,
                              onChanged: (DateTime date) {
                                mydate = date;
                                widget.onDateChange(mydate);
                              },
                              orders: state.timeDay.orders,
                            )
                          else
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Ishlanmidigan kun",
                                  style: AppTheme.displayLarge
                                      .copyWith(color: red),
                                ),
                              ),
                            )
                        ],
                      )
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
