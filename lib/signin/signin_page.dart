import 'package:expenses_app/showdialog.dart';
import 'package:expenses_app/signin/signin_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TextEditingControllerで入力文字のローカル保持
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(),
      child: Scaffold(
        appBar: AppBar(
          //Navigatorによって自動で生成される戻るボタンのデザイン変更
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Sign In',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
          ),
        ),
        body: Consumer<SignInModel>(builder: (context, model, child) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 50.0),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'メールアドレスを入力してください。';
                      }
                      return null;
                    },
                    controller: _emailController,
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
                    onChanged: (text) {
                      model.email = text;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (value) {
                      if (value.length < 8) {
                        return '８文字以上のパスワードを入力してください。';
                      }
                      return null;
                    },
                    controller: _passwordController,
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
                    onChanged: (text) {
                      model.password = text;
                    },
                  ),
                  SizedBox(height: 50.0),
                  RaisedButton(
                    color: Colors.blueGrey,
                    child: Text(
                      'サインイン',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        try {
                          await model.signIn();
                          SuccessShowDialog(context, 'ログイン完了');
                        } catch (e) {
                          ErrorShowDialog(context, '正しい情報を入力してください。');
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
