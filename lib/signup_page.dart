import 'package:expenses_app/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Sign Up',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Center(
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 50.0),
                TextFormField(
                  //入力中はdoneがnextになり、押下後に下のテキストフォームに移動
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'email',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'password',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                RaisedButton(
                  color: Colors.blueGrey,
                  child: Text(
                    '新規登録',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
