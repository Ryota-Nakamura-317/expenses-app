import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/model/expenses_data.dart';
import 'package:flutter/material.dart';

class AddModel extends ChangeNotifier {
  String price = '';
  String payments = '';
  String memo = '';
  Timestamp date;
  List<String> payment = ['現金', 'クレジットカード', 'QRコード', '交通系IC', '電子マネー'];

  Future add() async {
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc('details')
        .collection('expenses')
        .doc();
    await collection.set({
      'price': price,
      'payments': payments,
      'date': date,
      'memo': memo,
      'createdAt': Timestamp.now(),
    });
  }

  Future update(Expenses expenses) async {
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc('details')
        .collection('expenses')
        .doc(expenses.documentId);
    await collection.update({
      'price': price,
      'payments': payments,
      'date': date,
      'memo': memo,
      'createdAt': Timestamp.now(),
    });
  }
}
