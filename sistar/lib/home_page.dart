import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_apps/device_apps.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sistar/firestore_manager.dart';
import 'package:sistar/globals.dart';
import 'package:sistar/widgets/task_card.dart';

import 'custom_drawer.dart';
import 'model/task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initState()
  {
    FirebaseMessaging.instance.subscribeToTopic(user_global);
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tasks'),
        ),
        drawer: CustomDrawer(),
        body: buildFire());
  }

  final Stream<QuerySnapshot> _usersStream =
      FirestoreManager().taskReference.snapshots();

  Widget buildFire() {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }


        return ListView(
          children: snapshot.data!.docs.where((element) {

            var t = element.data() as Map<String, dynamic>;
            if (t["username"] == user_global) {
              return true;
            }
            return false;
          }).map((DocumentSnapshot document) {


            Task temp = taskFromMap(document.data() as Map<String, dynamic>, document.id);
            return TaskCard(instance: temp);
          }).toList(),
        );
      },
    );
  }
}
// DeviceApps.openApp('com.peter.sistarCam');
