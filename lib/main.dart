import 'package:expenses_app/signin_page.dart';
import 'package:expenses_app/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //table_calendar実行のために必要
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'さあ、はじめよう。',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 5.0,
                fontStyle: FontStyle.italic,
                shadows: <Shadow>[
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              '無駄のない生活を。',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 5.0,
                fontStyle: FontStyle.italic,
                shadows: <Shadow>[
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            SizedBox(height: 80.0),
            FlatButton(
              onPressed: () {
                //新規登録画面へ遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ),
                );
              },
              child: Text('新規登録'),
              textColor: Colors.black,
            ),
            SizedBox(height: 20.0),
            FlatButton(
              onPressed: () {
                //todo: ログイン画面へ遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(),
                  ),
                );
              },
              child: Text('サインイン'),
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
