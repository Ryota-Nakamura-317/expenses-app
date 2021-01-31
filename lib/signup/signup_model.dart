import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

  Future signUp() async {
    final user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    final uid = user.uid;

    FirebaseFirestore.instance.collection('users').doc('details').set(
      {
        'uid': uid,
        'email': email,
        'password': password,
        'createdAt': Timestamp.now(),
      },
    );
  }
}
