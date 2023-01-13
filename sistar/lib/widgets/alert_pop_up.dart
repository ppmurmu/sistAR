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
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
    ),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: Theme.of(context).brightness == Brightness.light
        ? Color.fromRGBO(240, 240, 240, 0.7)
        : Color.fromRGBO(78, 78, 78, 0.7),
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
