import 'package:expenses_app/screens/register/loading.dart';
import 'package:expenses_app/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //データ呼び出し専用のauth.dartの呼び出し
  //これでAuthServiceがこのクラスでも使用可能となる
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    //password入力フォームへのFocusNode定義
    final _passwordFocusNode = FocusNode();
    //Spinkitの設定と登録画面
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 15.0,
              title: Text(
                'New Account',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'email'),
                      validator: (val) =>
                          val.isEmpty ? 'メールアドレスを入力してください。' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      //カーソル移動処理
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                    ),
                    TextFormField(
                      //カーソル移動先
                      focusNode: _passwordFocusNode,
                      decoration: InputDecoration(labelText: 'password'),
                      validator: (val) =>
                          val.length < 8 ? 'パスワードを8文字以上で入力してください。' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      obscureText: true,
                    ),
                    SizedBox(height: 50.0),
                    RaisedButton(
                      child: Text(
                        '登録',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = '有効なメールアドレスを入力してください。';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
