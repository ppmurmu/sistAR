import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistar/globals.dart';
import 'package:sistar/task_screen.dart';

import '../model/task.dart';

class TaskCard extends StatelessWidget {
  Task instance;

  TaskCard({Key? key, required this.instance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10, left: 20.0, right: 20.0),
      child: Material(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaskScreen(instance: instance)),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: colorMap[instance.status]),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo: customizable textStyle

                  Text(
                    instance.taskName,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    instance.status,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.manage_accounts,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        instance.username,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                ],
              ),
            ),
          ),
        ),
        color: Colors.transparent,
      ),
    );
  }
}
