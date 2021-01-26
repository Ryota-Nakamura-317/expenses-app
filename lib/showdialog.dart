import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

Future SuccessShowDialog(BuildContext context, String title) {
  AwesomeDialog(
    context: context,
    animType: AnimType.LEFTSLIDE,
    headerAnimationLoop: false,
    dialogType: DialogType.SUCCES,
    title: 'Success',
    desc: title,
    btnOkOnPress: () {},
    btnOkIcon: Icons.check_circle,
  )..show();
}

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
