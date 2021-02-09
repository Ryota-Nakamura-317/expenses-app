import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/model/expenses_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddModel extends ChangeNotifier {
  String price = '';
  String payments = '';
  String memo = '';
  String category = '';
  Timestamp date;
  List<String> payment = ['現金', 'クレジットカード', 'QRコード', '交通系IC', '電子マネー'];
  List<String> categoryList = [
    '住居費',
    '水道光熱費',
    '通信費',
    '保険料',
    '食費',
    '日用品費',
    '被服費',
    '美容費',
    '交際費',
    '交通費',
  ];

  //TextEditingController memoEditingController = TextEditingController();

  Future add(ExpensesUser expenses) async {
    final userId = FirebaseAuth.instance.currentUser.uid;
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .doc();
    await collection.set({
      'price': price,
      'payments': payments,
      'category': category,
      'date': date,
      'memo': memo,
      'createdAt': Timestamp.now(),
    });
  }

  Future update(ExpensesUser expenses) async {
    final userId = FirebaseAuth.instance.currentUser.uid;
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .doc(expenses.documentId);
    await collection.update({
      'price': price,
      'payments': payments,
      'category': category,
      'date': date,
      'memo': memo,
      'createdAt': Timestamp.now(),
    });
  }

  Future delete(ExpensesUser expenses) async {
    final userId = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .doc(expenses.documentId)
        .delete();
  }
}
