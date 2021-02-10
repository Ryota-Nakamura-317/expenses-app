import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expenses_app/screens/screen.dart';
import 'package:flutter/material.dart';

//サインイン、サインアップ成功時のダイアログ
void SuccessShowDialog(BuildContext context, String title) {
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
          builder: (BuildContext context) => ScreenChangePage(),
        ),
      );
    },
    btnOkIcon: Icons.check_circle,
  )..show();
}

//サインイン、サインアップ失敗時のダイアログ
void ErrorShowDialog(BuildContext context, String title) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.ERROR,
    animType: AnimType.RIGHSLIDE,
    headerAnimationLoop: false,
    title: 'Error',
    desc: title,
    btnOkOnPress: () {},
    btnOkIcon: Icons.cancel,
    btnOkColor: Colors.red,
  )..show();
}

//削除時ダイアログ
void DeleteDialog(BuildContext context, String title) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.WARNING,
    animType: AnimType.TOPSLIDE,
    headerAnimationLoop: true,
    title: '確認',
    desc: title,
    btnOkColor: Colors.orangeAccent,
    btnOkOnPress: () {
      Navigator.pop(context);
    },
  )..show();
}
