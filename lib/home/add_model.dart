import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddModel extends ChangeNotifier {
  int price = 0;
  String payments = '';
  Timestamp date;
  String memo = '';

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
    });
  }
}
