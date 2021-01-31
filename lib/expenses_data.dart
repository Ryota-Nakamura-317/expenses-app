import 'package:cloud_firestore/cloud_firestore.dart';

class Expenses {
  Expenses(DocumentSnapshot doc) {
    this.documentId = doc.id;
    this.price = doc.data()['price'];
    this.payments = doc.data()['payments'];
    this.memo = doc.data()['memo'];
    this.date = doc.data()['date'];
    this.createdAt = doc.data()['createdAt'];
  }
  int price = 0;
  String payments = '';
  String memo = '';
  String documentId;
  Timestamp date;
  Timestamp createdAt;
}

/*
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
*/
