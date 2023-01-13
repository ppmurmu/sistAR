import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistar_web/create_form.dart';
import 'package:sistar_web/task.dart';
import 'package:sistar_web/task_card.dart';
import 'firestore_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initState() {
    totalTask();
  }

  String tt = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("sistAR Dashboard"),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tasks",
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        createForm(context);
                      },
                      child: Text("Create Task"))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  thickness: 0.5,
                  color: Color(0xFF5E5E5E),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: Container(
                            width: 100, child: Text("ID", style: TextStyle(color: Colors.grey),))),
                    Container(width: 200, child: Text("Task",style: TextStyle(color: Colors.grey))),
                    Center(
                      child: Container(
                        width: 300,
                        child: Text("Description", style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Text("Assigned to", style: TextStyle(color: Colors.grey)),
                    ),
                    Container(
                      width: 200,
                      child: Text("Status", style: TextStyle(color: Colors.grey)),
                    ),
                    Container(
                      width: 100,
                      child: Text("Delete", style: TextStyle(color: Colors.grey)),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  thickness: 0.5,
                  color: Color(0xFF5E5E5E),
                ),
              ),
              Container(height: 1000, child: buildFire())
            ]),
          ),
        ));
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
          return Center(child: Text("Loading"));
        }
        return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
          print(document.id);
          Task temp =
              taskFromMap(document.data() as Map<String, dynamic>, document.id);
          return TaskCard(instance: temp);
        }).toList());
      },
    );
  }

  void totalTask() {
    FirestoreManager().taskReference.get().then((querySnapshot) {
      setState(() {
        tt = querySnapshot.size.toString();
      });
    });
  }
}
