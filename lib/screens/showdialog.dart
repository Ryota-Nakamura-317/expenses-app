import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expenses_app/home/home.dart';
import 'package:flutter/material.dart';

//サインイン、サインアップ成功時のダイアログ
Future SuccessShowDialog(BuildContext context, String title) async {
  AwesomeDialog(
    context: context,
    animType: AnimType.LEFTSLIDE,
    headerAnimationLoop: false,
    dialogType: DialogType.SUCCES,
    title: 'Success',
    desc: title,
    btnOkOnPress: () async {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
      );
    },
    btnOkIcon: Icons.check_circle,
  )..show();
}

//サインイン、サインアップ失敗時のダイアログ
Future ErrorShowDialog(BuildContext context, String title) {
  AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.RIGHSLIDE,
      headerAnimationLoop: false,
      title: 'Error',
      desc: title,
      btnOkOnPress: () {},
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red)
    ..show();
}
