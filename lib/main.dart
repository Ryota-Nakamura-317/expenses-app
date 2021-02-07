import 'package:expenses_app/model/expenses_data.dart';
import 'package:expenses_app/model/login_check.dart';
import 'package:expenses_app/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //table_calendar実行のために必要
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>.value(
      value: UserState().user,
      child: MaterialApp(
        title: 'Expenses App',
        home: Wrapper(),
      ),
    );
  }
}
