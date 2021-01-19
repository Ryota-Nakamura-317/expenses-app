import 'package:expenses_app/screens/home/add_expenses.dart';
import 'package:expenses_app/screens/home/home2.dart';
import 'package:expenses_app/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 15.0,
        title: Text(
          'rita',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
        ),
        actions: [
          //相方の支出リストへ移動
          IconButton(
            icon: Icon(Icons.supervisor_account),
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home2(),
                  ));
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.black,
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      //
      body: ListView(),
      //支出の追加入力フォーム
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.playlist_add_outlined),
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddExpenses(),
              ));
        },
      ),
    );
  }
}
