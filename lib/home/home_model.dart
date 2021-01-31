import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePageModel extends ChangeNotifier {
  CalendarController calendarController = CalendarController();

  void onDaySelected(DateTime date, event, _) {
    Timestamp selectedDay = Timestamp.fromDate(date.add(Duration(hours: -21)));
    DateTime lastDay = date.add(Duration(hours: 12, microseconds: -1));
    Timestamp lastDayTimestamp = Timestamp.fromDate(lastDay);
    print(lastDayTimestamp);
  }
}
