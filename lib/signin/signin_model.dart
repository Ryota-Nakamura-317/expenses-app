import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInModel extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

  Future signIn() async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    //todo ここでuid取得して端末に保存してからfirestore読み込み？
  }
}
