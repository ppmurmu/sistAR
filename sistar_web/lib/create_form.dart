import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sistar_web/alert_pop_up.dart';
import 'package:sistar_web/assign_to_dropdown.dart';
import 'package:sistar_web/firestore_manager.dart';
import 'package:sistar_web/task_dropdown.dart';
import 'package:http/http.dart' as http;

createForm(
  BuildContext context,
) {
  String description = "";
  String task_name = "";
  String username = "";

  void sendNotification() async {
    try {
      final response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization":
              "key=AAAAAgcCVMg:APA91bEqHUWoCRfRi9R_oSDWy0UXcBsh8l8TL4UgmBrQkf1cUCADCoKt9q1VLIzXzjv7FcIE-Dr3NQTXf8xAB_Gs2_p-EjossKQVhFEQVFFPekaxl2M8XE8MeeB9uWDF_D4mYFlveyZv"
        },
        body: jsonEncode(<String, dynamic>{
          "notification": {
            "title": "Alert: New Task!",
            "body": task_name,
            "content_available": true
          },
          "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK"},
          "to": "/topics/${username}"
        }),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print("sent");
      } else {
        throw Exception('Failed to add details');
      }
    } catch (e) {}
  }

  Future<void> addTask() {
    return FirestoreManager().taskReference.add({
      'task_name': task_name,
      'description': description,
      'username': username,
      "status": "pending"
    }).then((value) {
      showAlertDialogPopup(context, "Task added successfully!", "Close", () {
        sendNotification();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }, true);
    }).catchError((error) {
      showAlertDialogPopup(context, "Server error!", "Close", () {
        Navigator.of(context).pop();
      }, true);
    });
  }

  void validate() {
    if (task_name == "" || description == "" || username == "") {
      showAlertDialogPopup(context, "Some fields are empty", "Retry", () {
        Navigator.of(context).pop();
      }, true);
    } else {
      addTask();
    }
  }

  // Create button
  Widget okButton = ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        Colors.green,
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    ),
    onPressed: () {
      validate();
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Submit",
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    ),
  );
  Widget cancelButton = ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        Colors.red,
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    ),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text('Create Task'),
    content: Container(
      child: Container(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskDropDown(value: (value) {
              task_name = value;
            }),
            SizedBox(
              height: 20,
            ),
            AssignToDropDown(value: (value) {
              username = value;
            }),
            SizedBox(
              height: 20,
            ),
            TextField(

                //controller: u,
                onChanged: (s) {
                  description = s;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ),
    actions: [okButton, cancelButton],
  );

  showGeneralDialog(
    barrierDismissible: false,
    barrierLabel: '',
    //barrierColor: Colors.black38,
    //transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (context, anim1, anim2) => alert,

    context: context,
  );
}
