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
  String price = '';
  String payments = '';
  String memo = '';
  String documentId;
  Timestamp date;
  Timestamp createdAt;
}
