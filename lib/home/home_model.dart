import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/model/expenses_data.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePageModel extends ChangeNotifier {
  CalendarController calendarController = CalendarController();
  List<Expenses> expensesList = [];
  Timestamp _selectedDay;
  Timestamp _lastDayTimestamp;

  void onDaySelected(DateTime date, event, _) {
    Timestamp selectedDay = Timestamp.fromDate(date.add(Duration(hours: -21)));
    DateTime lastDay = date.add(Duration(hours: 12, microseconds: -1));
    Timestamp lastDayTimestamp = Timestamp.fromDate(lastDay);
    _selectedDay = selectedDay;
    _lastDayTimestamp = lastDayTimestamp;
  }

  void getExpensesListRealTime() {
    final snapshots = FirebaseFirestore.instance
        .collection('users')
        .doc('details')
        .collection('expenses')
        .where(
          'date',
          isEqualTo: _selectedDay,
        )
        .where('date', isEqualTo: _lastDayTimestamp)
        .snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final expensesList = docs.map((doc) => Expenses(doc)).toList();
      this.expensesList = expensesList;
      notifyListeners();
    });
  }
}
