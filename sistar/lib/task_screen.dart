import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:sistar/firestore_manager.dart';
import 'package:sistar/globals.dart';
import 'package:sistar/widgets/custom_round_button.dart';

import 'model/task.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({Key? key, required this.instance}) : super(key: key);
  Task instance;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task"),
        backgroundColor: colorMap[widget.instance.status],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.instance.taskName,
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  thickness: 0.5,
                  color: Color(0xAB5E5E5E),
                ),
              ),

              Row(
                children: [
                  Text("Description: ", style: TextStyle(fontSize: 15, color: Colors.grey),),
                  Text(
                    widget.instance.description,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: CustomRoundButton(
                  text: "AR Assist",
                  onPressed: () {
                    activeTask();
                    DeviceApps.openApp('com.peter.sistarCam');
                  },
                  color: Colors.yellow,
                ),
              ),
              SizedBox(height: 20,),
              (widget.instance.status!="completed" ?Center(
                child: CustomRoundButton(
                  text: "Mark Complete",
                  onPressed: () {
                    completeTask();

                  },
                  color: Colors.green,
                ),
              ) : Center(child: Text("Task already completed", style: TextStyle(fontSize: 20, color: Colors.green),)))


            ],
          ),
        ),
      ),
    );
  }

  Future<void> completeTask() {
    return FirestoreManager()
        .taskReference
        .doc(widget.instance.id)
        .update({'status': "completed"})
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task completed!"),
        duration: Duration(milliseconds: 5000),
      ),
    ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Server Error!"),
        duration: Duration(milliseconds: 2000),
      ),
    ));
  }
  Future<void> activeTask() {
    return FirestoreManager()
        .taskReference
        .doc(widget.instance.id)
        .update({'status': "active"})
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task active!"),
        duration: Duration(milliseconds: 5000),
      ),
    ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Server Error!"),
        duration: Duration(milliseconds: 2000),
      ),
    ));
  }
}
