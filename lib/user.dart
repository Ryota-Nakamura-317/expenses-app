import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String email;
  final String password;
  final String uid;
  final String payment;
  final int price;
  Timestamp createdAt;

  UserData({
    this.email,
    this.password,
    this.uid,
    this.payment,
    this.price,
  });
}
