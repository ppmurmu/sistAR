import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistar_web/alert_pop_up.dart';
import 'package:sistar_web/firestore_manager.dart';

import 'package:sistar_web/task.dart';

const Map<String, Color> colorMap = {
  "active": Color(0xFFFFBF00),
  "completed": Color(0xC90EAB67),
  "pending": Color(0xFFFF6666),
};

class TaskCard extends StatelessWidget {
  Task instance;

  TaskCard({Key? key, required this.instance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Container(
                      width: 100, child: Text(instance.id.substring(0, 5)))),
              Container(width: 200, child: Text(instance.taskName)),
              Center(
                child: Container(
                  width: 300,
                  child: Text(instance.description),
                ),
              ),
              Container(
                width: 200,
                child: Text(instance.username),
              ),
              Container(
                width: 200,
                child: Text(instance.status, style: TextStyle(color: colorMap[instance.status]),),
              ),
              IconButton(
                  onPressed: () {
                    showAlertDialogPopup(context, "Confirm Delete?", "Delete", () {
                      deleteTask(context);
                      Navigator.of(context).pop();
                    }, true);
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Divider(
              thickness: 0.5,
              color: Color(0xA45E5E5E),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> deleteTask(context) {
    return FirestoreManager()
        .taskReference
        .doc(instance.id)
        .delete()
        .then((value) {
      showAlertDialogPopup(context, "Task deleted successfully!", "Close", () {

        Navigator.of(context).pop();
      }, false);
    }).catchError((error) {
      showAlertDialogPopup(context, "Server Error!", "Close", () {
        Navigator.of(context).pop();
      }, true);
    });
  }
}
