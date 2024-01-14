import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iris_app/screens/admin/dashboard.dart';
import 'package:iris_app/screens/user/homescreen.dart';
import 'package:iris_app/widgets/allwidgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _rollNoTextController = TextEditingController();
  TextEditingController _messBalanceTextController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 52, 1, 141),
          ),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Full Name", Icons.person_outline,
                    false, _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Roll Number", Icons.numbers, false,
                    _rollNoTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Add Mess Balance", Icons.currency_rupee,
                    false, _messBalanceTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () {
                  final user = <String, dynamic>{
                    "Name": _userNameTextController.text,
                    "Email": _emailTextController.text,
                    "MessBalance": _messBalanceTextController.text,
                    "RollNo": _rollNoTextController.text,
                    "CurrentMess": "",
                    "approved" : true,
                    "NextMess":""
                  };

                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    print("Created New Account");
                    db
                        .collection("user_info")
                        .doc((FirebaseAuth.instance.currentUser!).uid)
                        .set(user)
                        .whenComplete(() => print("Done"));
                    if (_emailTextController.text == "admin@gmail.com") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashboardScreen()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    }
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                })
              ],
            ),
          ))),
    );
  }
}
