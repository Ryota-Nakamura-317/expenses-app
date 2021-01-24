import 'package:cloud_firestore/cloud_firestore.dart';

class ExpensesUser {
  final String uid;
  ExpensesUser({this.uid});
}

class ExpensesData {
  final String payment;
  final String price;
  Timestamp createdAt;

  ExpensesData({this.payment, this.price, this.createdAt});
}
