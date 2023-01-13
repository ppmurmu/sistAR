import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyCI-5VnW-E-ub7cHiFuW-3xnmXhf9-7xS4",
    authDomain: "sistar-ae654.firebaseapp.com",
    projectId: "sistar-ae654",
    storageBucket: "sistar-ae654.appspot.com",
    messagingSenderId: "8707527880",
    appId: "1:8707527880:web:a27c34b8b66cd4d710c1fd",
    measurementId: "G-SDBBXR4SWF",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sistAR web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
