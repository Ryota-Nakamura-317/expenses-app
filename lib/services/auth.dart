import 'package:expenses_app/model/user.dart';
import 'package:expenses_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user based on firebase
  UserData _userFromFirebase(User user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserData> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      await DatabaseService(uid: user.uid).updateUserData('card', '0', '1/23');
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
