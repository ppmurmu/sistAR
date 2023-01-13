import 'dart:ui';
import 'package:flutter/material.dart';

import 'custom_round_button.dart';

TwoButtonDialogPopup(BuildContext context, String alertText, String buttonText, String button2Text, String heading,
    Function() button1Func, Function() button2Func) {
  // Create button
  Widget okButton =ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        Colors.blueAccent,
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    ),
    onPressed: () {
      button1Func();
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
       buttonText,
        style: TextStyle(color: Colors.black, fontSize: 12),

      ),
    ),
  );



  Widget cancelButton = ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        Colors.redAccent,
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    ),
    onPressed: () {
      button2Func();
    },
    child: Text(button2Text),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)),
    backgroundColor:  Theme.of(context).brightness == Brightness.light
        ? Color.fromRGBO(	240, 240, 240, 0.7)
        : Color.fromRGBO(	78, 78, 78, 0.7),
    elevation: 0,
    title: Text(heading),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          alertText,
          style: TextStyle(fontSize: 17),
        ),
      ],
    ),
    actions: [okButton, cancelButton],
  );

  showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: '',
    // barrierColor: Colors.black38,
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (context, anim1, anim2) => alert,
    transitionBuilder: (context, anim1, anim2, child) => BackdropFilter(
      filter:
      ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
      child: FadeTransition(
        child: child,
        opacity: anim1,
      ),
    ),
    context: context,
  );
}