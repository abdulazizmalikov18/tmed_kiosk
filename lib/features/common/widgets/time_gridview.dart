import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/day_orders.dart';

class TimeGridView extends StatefulWidget {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Function(DateTime date) onChanged;
  final DateTime dateTime;
  final List<DayOrderEntity> orders;

  const TimeGridView({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onChanged,
    required this.dateTime,
    required this.orders,
  });

  @override
  State<TimeGridView> createState() => _TimeGridViewState();
}

class _TimeGridViewState extends State<TimeGridView> {
  int indexD = -1;
  late List<TimeOfDay> times;
  List<TimeOfDay> timesOrder = [];
  DateTime dateNow = DateTime.now();
  @override
  void initState() {
    times = _generateTimes();
    indexD = times.indexWhere((element) =>
        element ==
        TimeOfDay(hour: widget.dateTime.hour, minute: widget.dateTime.minute));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        maxCrossAxisExtent: 80,
        mainAxisExtent: 50,
      ),
      shrinkWrap: true,
      itemCount: times.length,
      itemBuilder: (context, index) {
        String formattedTime =
            '${times[index].hour.toString().padLeft(2, '0')}:${times[index].minute.toString().padLeft(2, '0')}';
        DateTime date = DateTime(
          widget.dateTime.year,
          widget.dateTime.month,
          widget.dateTime.day,
          times[index].hour,
          times[index].minute,
        );
        return WButton(
          isDisabled: timesOrder
                  .where((element) => element == times[index])
                  .isNotEmpty ||
              date.isBefore(dateNow),
          onTap: () {
            indexD = index;
            widget.onChanged(date);
            setState(() {});
          },
          color: index != indexD ? white : null,
          textColor: index == indexD ? white : dark,
          shadow: wboxShadow,
          text: timesOrder.where((element) => element == times[index]).isEmpty
              ? date.isAfter(dateNow)
                  ? formattedTime
                  : "Vaqt otgan"
              : "Busy",
        );
      },
    );
  }

  List<TimeOfDay> _generateTimes() {
    List<TimeOfDay> times = [];
    TimeOfDay currentTime = widget.startTime;
    for (var i = 0; i < widget.orders.length; i++) {
      final salom = DateTime.parse(widget.orders[i].meetDate
          .substring(0, widget.orders[i].meetDate.length - 6));
      timesOrder.add(TimeOfDay.fromDateTime(salom));
    }

    while (currentTime.hour < widget.endTime.hour ||
        (currentTime.hour == widget.endTime.hour &&
            currentTime.minute <= widget.endTime.minute)) {
      times.add(currentTime);
      int nextMinute = currentTime.minute + 15;
      currentTime = TimeOfDay(hour: currentTime.hour, minute: nextMinute % 60);
      if (nextMinute >= 60) {
        currentTime = TimeOfDay(hour: currentTime.hour + 1, minute: 0);
      }
    }

    return times;
  }
}
