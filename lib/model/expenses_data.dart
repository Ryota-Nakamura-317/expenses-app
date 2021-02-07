import 'package:cloud_firestore/cloud_firestore.dart';

class ExpensesUser {
  String uid;
  String price = '';
  String payments = '';
  String memo = '';
  String documentId;
  String category;
  Timestamp date;
  Timestamp createdAt;

  ExpensesUser(DocumentSnapshot doc) {
    this.uid = doc.data()['uid'];
    this.documentId = doc.id;
    this.price = doc.data()['price'];
    this.payments = doc.data()['payments'];
    this.category = doc.data()['category'];
    this.memo = doc.data()['memo'];
    this.date = doc.data()['date'];
    this.createdAt = doc.data()['createdAt'];
  }
}

class AppUser {
  final String uid;

  AppUser({this.uid});
}
