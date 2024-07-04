import 'package:flutter/material.dart';
import 'package:calendar_agenda/calendar_agenda.dart';
import '../../styles/colors/colors.dart';

class DailySchedule extends StatefulWidget {
  final ValueChanged<int> onDateSelected;
  final int? initialDate; // New property to receive initial date

  const DailySchedule(
      {required this.onDateSelected, this.initialDate, Key? key})
      : super(key: key);

  @override
  State<DailySchedule> createState() => _DailyScheduleState();
}

class _DailyScheduleState extends State<DailySchedule> {
  late int _selectedDateAppBar;

  @override
  void initState() {
    super.initState();
    // Initialize selected date with initialDate if provided, otherwise use today's date
    _selectedDateAppBar = widget.initialDate ?? DateTime.now().day;
  }

  @override
  Widget build(BuildContext context) {
    return CalendarAgenda(
      appbar: false,
      selectedDayPosition: SelectedDayPosition.center,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      weekDay: WeekDay.long,
      dayNameFontSize: 12,
      dayNumberFontSize: 16,
      titleSpace: 10,
      dayBackgroundColor: Colors.grey.withOpacity(0.2),
      backgroundColor: Colors.white,
      fullCalendarScroll: FullCalendarScroll.horizontal,
      fullCalendarDay: WeekDay.long,
      selectedDateColor: Colors.white,
      dateColor: Ucolor.black,
      headerDateColor: Colors.black,
      locale: 'en',
      initialDate: DateTime.now(),
      calendarEventColor: Colors.black,
      firstDate: DateTime.now().subtract(Duration(days: 140)),
      lastDate: DateTime.now().add(Duration(days: 60)),
      onDateSelected: (date) {
        setState(() {
          _selectedDateAppBar = date.day;
          int monthNumber = date.month;
          int dayNumber = date.day;
          int yearNumber = date.year;
          int id = int.parse(
              '$yearNumber${monthNumber < 10 ? '0$monthNumber' : monthNumber}${dayNumber < 10 ? '0$dayNumber' : dayNumber}');
          widget.onDateSelected(id);
        });
      },
      selectedDayLogo: Container(
        decoration: BoxDecoration(
            color: Colors.black54, borderRadius: BorderRadius.circular(10)),
        width: double.maxFinite,
        height: double.maxFinite,
      ),
    );
  }
}
