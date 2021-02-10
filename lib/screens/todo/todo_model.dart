import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/model/todo_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoModel extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final userId = FirebaseAuth.instance.currentUser.uid;
  List<TodoData> todoList = [];
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Future signOut() async {
    await _auth.signOut();
  }

  void getTodoListRealTime() {
    final querySnapshot = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('todo')
        .snapshots();
    querySnapshot.listen((snapshot) {
      final docs = snapshot.docs;
      final todoList = docs.map((doc) => TodoData(doc)).toList();
      todoList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      this.todoList = todoList;
      notifyListeners();
    });
  }

  void reload() {
    notifyListeners();
  }
}
