import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/model/expenses_data.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePageModel extends ChangeNotifier {
  CalendarController calendarController = CalendarController();
  List<Expenses> expensesList = [];

  void onDaySelected(DateTime date, event, _) {
    Timestamp selectedDay = Timestamp.fromDate(date.add(Duration(hours: -12)));
    DateTime lastDay = date.add(Duration(hours: 12, microseconds: -1));
    Timestamp lastDayTimestamp = Timestamp.fromDate(lastDay);
    print(date.add(Duration(hours: -12)));
    print(date.add(Duration(hours: 12, microseconds: -1)));

    final querySnapshot = FirebaseFirestore.instance
        .collection('users')
        .doc('details')
        .collection('expenses')
        .where('date',
            isGreaterThanOrEqualTo: selectedDay,
            isLessThanOrEqualTo: lastDayTimestamp)
        .snapshots();
    querySnapshot.listen((snapshot) {
      final docs = snapshot.docs;
      final expensesList = docs.map((doc) => Expenses(doc)).toList();
      this.expensesList = expensesList;
      notifyListeners();
    });
  }

  /*void getExpensesListRealTime() {
    final querySnapshot = FirebaseFirestore.instance
        .collection('users')
        .doc('details')
        .collection('expenses')
        .where('date',
            isGreaterThan: _selectedDay, isLessThan: _lastDayTimestamp)
        .snapshots();
    querySnapshot.listen((snapshot) {
      final docs = snapshot.docs;
      final expensesList = docs.map((doc) => Expenses(doc)).toList();
      this.expensesList = expensesList;
      notifyListeners();
    });
  }*/
}
