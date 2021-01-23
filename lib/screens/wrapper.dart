import 'package:expenses_app/model/user.dart';
import 'package:expenses_app/screens/authenticate/authenticate.dart';
import 'package:expenses_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
