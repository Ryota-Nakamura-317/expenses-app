import 'package:expenses_app/signup/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TextEditingControllerで入力文字のローカル保持
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    //validationのためのKey設定
    final _formKey = GlobalKey<FormState>();
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
        body: Consumer<SignUpModel>(builder: (context, model, child) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Center(
              key: _formKey,
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 50.0),
                  TextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'メールアドレスを入力してください。' : null,
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
                    validator: (value) =>
                        value.length < 8 ? 'パスワードは８文字以上で設定してください。' : null,
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
                      '新規登録',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result = await model.signUp();
                        if (result == null) {
                          return null;
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
