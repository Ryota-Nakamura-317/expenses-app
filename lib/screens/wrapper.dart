import 'package:expenses_app/model/user.dart';
import 'package:expenses_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

    // todo: user情報があればHomeへ、なければRegisterへ遷移する処理を書く
    //ログインシステムに関しては後に決定

    return Home();
  }
}
