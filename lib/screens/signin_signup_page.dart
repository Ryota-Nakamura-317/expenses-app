import 'package:expenses_app/screens/signin/signin_page.dart';
import 'package:expenses_app/screens/signup/signup_page.dart';
import 'package:flutter/material.dart';

class SignInSignUpPage extends StatelessWidget {
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
                Navigator.pushReplacement(
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    //todo 後でサインインページに変更！
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
