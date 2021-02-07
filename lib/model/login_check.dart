import 'package:expenses_app/model/expenses_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser _userFromFirebase(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }
}
