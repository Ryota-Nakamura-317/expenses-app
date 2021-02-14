import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/model/expenses_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePageModel extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final userId = FirebaseAuth.instance.currentUser.uid;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  CalendarController calendarController = CalendarController();
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  List<ExpensesUser> expensesList = [];
  int _currentIndex = 0;
  int totalPrice;

  void onDaySelected(DateTime date, event, _) {
    Timestamp selectedDay =
        Timestamp.fromDate(date.add(Duration(days: -1, hours: -12)));
    DateTime lastDay =
        date.add(Duration(days: -1, hours: 12, microseconds: -1));
    Timestamp lastDayTimestamp = Timestamp.fromDate(lastDay);

    final querySnapshot = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .where('date', isGreaterThan: selectedDay, isLessThan: lastDayTimestamp)
        .snapshots();
    querySnapshot.listen((snapshot) {
      final docs = snapshot.docs;
      final expensesList = docs.map((doc) => ExpensesUser(doc)).toList();
      expensesList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      this.expensesList = expensesList;
      notifyListeners();
    });
  }

  Future signOut() async {
    await _auth.signOut();
  }

  void getTotalPrice() {
    final date = DateTime.now();
    DateTime firstDay = DateTime(date.year, date.month, 1);
    DateTime nextMonthFirstDay = DateTime(date.year, date.month + 1, 1);
    DateTime lastDay = nextMonthFirstDay.add(Duration(days: -1));
    Timestamp firstDate = Timestamp.fromDate(firstDay);
    Timestamp lastDate = Timestamp.fromDate(lastDay);

    final snapshots = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .where('date', isGreaterThan: firstDate, isLessThan: lastDate)
        .snapshots();

    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final priceList =
          docs.map((doc) => int.parse(doc.data()['price'])).toList();
      final sum = priceList.reduce((curr, next) => curr + next);
      this.totalPrice = sum;
      notifyListeners();
    });
  }

  get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
