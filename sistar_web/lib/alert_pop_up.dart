import 'dart:ui';
import 'package:flutter/material.dart';

showAlertDialogPopup(BuildContext context, String alertText, String buttonText,
    Function() fun, bool barrierDismiss) {
  // Create button
  Widget okButton = ElevatedButton(
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
      fun();
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    ),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text('Alert'),
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
    actions: [
      okButton,
    ],
  );

  showGeneralDialog(
    barrierDismissible: barrierDismiss,
    barrierLabel: '',
    //barrierColor: Colors.black38,
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (context, anim1, anim2) => alert,

    context: context,
  );
}
