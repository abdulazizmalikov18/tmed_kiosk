import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class ShowCalendar extends StatefulWidget {
  const ShowCalendar({super.key});

  @override
  State<ShowCalendar> createState() => _ShowCalendarState();
}

class _ShowCalendarState extends State<ShowCalendar> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
    Navigator.of(context).pop(); //return date in format
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Container(
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxHeight: 324),
        width: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: contColor,
          border: Border.all(color: white.withOpacity(.1)),
        ),
        child: TableCalendar(
          locale: 'en_US',
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2022, 10, 16),
          lastDay: DateTime.utc(2025, 10, 16),
          calendarStyle: CalendarStyle(
            todayTextStyle: const TextStyle(fontSize: 14),
            outsideTextStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: grey,
            ),
            outsideDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            weekendTextStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            defaultDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            todayDecoration: BoxDecoration(
              border: Border.all(color: grey),
              borderRadius: BorderRadius.circular(4),
              color: whiteGrey,
            ),
            selectedDecoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.circular(4),
            ),
            selectedTextStyle: const TextStyle(
              fontSize: 14,
              color: white,
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            headerPadding: EdgeInsets.all(0),
            leftChevronPadding: EdgeInsets.symmetric(horizontal: 12),
            rightChevronPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
          rowHeight: 36,
          daysOfWeekHeight: 36,
          selectedDayPredicate: (day) => isSameDay(day, today),
          onDaySelected: _onDaySelected,
        ),
      ),
    );
  }
}
