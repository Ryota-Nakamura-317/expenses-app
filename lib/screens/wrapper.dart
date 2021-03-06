import 'package:expenses_app/model/expenses_data.dart';
import 'package:expenses_app/screens/screen.dart';
import 'package:expenses_app/screens/signin_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    if (user == null) {
      return SignInSignUpPage();
    } else {
      return ScreenChangePage();
    }
  }
}
