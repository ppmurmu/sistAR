import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sistar/globals.dart';
import 'package:sistar/login.dart';
import 'package:sistar/widgets/custom_drawer_header.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: Theme.of(context).cardColor,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  //borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [Color(0xFF0066C2), Color(0xFF8FC1FB)])
                  //color: colorMap[widget.name],
                  ),
              child: CustomDrawerHeader(),
            ),
            ListTile(
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                RichText(
                  text: TextSpan(
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      text: "Log Out" //'Select Class: ',
                      ),
                ),
              ]),
              onTap: () {
                FirebaseMessaging.instance.unsubscribeFromTopic(user_global);
                user_global="";
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                    (route) => false);
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
