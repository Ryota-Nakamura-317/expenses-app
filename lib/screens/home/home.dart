import 'package:expenses_app/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 15.0,
        title: Text(
          '支出リスト',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
        ),
        actions: [
          FlatButton.icon(
              icon: Icon(Icons.logout),
              label: Text('ログアウト'),
              onPressed: () async {
                await _auth.signOut();
              }),
        ],
      ),
    );
  }
}
