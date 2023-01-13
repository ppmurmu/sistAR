import 'package:flutter/material.dart';
import 'package:sistar/firestore_manager.dart';
import 'package:sistar/globals.dart';
import 'package:sistar/home_page.dart';
import 'package:sistar/widgets/alert_pop_up.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController u = TextEditingController();
  TextEditingController p = TextEditingController();
  String username = "";
  String password = "";

  void initState() {


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
              ),
              Center(
                child: Text(
                  "sistAR mobile",
                  style: TextStyle(fontSize: 40),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                  //controller: u,
                  onChanged: (s) {
                    username = s;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  )),
              SizedBox(
                height: 20,
              ),
              TextField(
                  // controller: p,
                  onChanged: (s) {
                    password = s;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  )),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  validateLogin();
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void validateLogin() {
    if (username == "" && password == "") {
      showAlertDialogPopup(context, "Wrong username/password", "Cancel", () {
        Navigator.of(context).pop();
      }, true);
    } else {
      loginFunc(username, password);
    }
  }

  void loginFunc(String u, String p) {
    try {
      FirestoreManager()
          .userReference
          .where('username', isEqualTo: u)
          .snapshots()
          .listen((data) {
        if (data.docs[0]['password'] == p) {
          user_global = u;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        } else {
          print("false pass");

        }
      });
    } catch (e) {
      print("excepkfepg");
      showAlertDialogPopup(context, "Login failed!", "retry", () {
        Navigator.of(context).pop();
      }, true);
      // print(e);
    }
  }
}
