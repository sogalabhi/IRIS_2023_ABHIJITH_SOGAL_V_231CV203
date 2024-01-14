import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iris_app/screens/user/homescreen.dart';

class MessDetailsScreen extends StatelessWidget {
  final QuerySnapshot<Object?> user;
  final int index;
  const MessDetailsScreen({super.key, required this.user, required this.index});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Mess Details"),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                user.docs[index]["name"],
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text("Vacancy: " +
                  user.docs[index]["vacancy"].toString() +
                  "/" +
                  user.docs[index]["total"].toString()),
              const SizedBox(height: 20),
              Text(user.docs[index]["type"]),
              ElevatedButton(
                  onPressed: () {
                    final ref = FirebaseFirestore.instance
                        .collection("user_info")
                        .doc((FirebaseAuth.instance.currentUser!).uid);
                    FirebaseFirestore.instance
                        .collection("mess_list")
                        .where('name', isEqualTo: user.docs[index]["name"])
                        .get()
                        .then((value) {
                      if (value.size == 1) {
                        final snap = value.docs[0];
                        print(snap.reference.id);

                        int oldV = snap['vacancy'];
                        print(oldV.toString());

                        FirebaseFirestore.instance
                        .collection("mess_list").doc(snap.reference.id).update({"vacancy": oldV + 1}).then(
                            (value) => print("$oldV successfully updated!"),
                            onError: (e) =>
                                print("Error updating document $e"));
                      }
                      else {
                        print("query result in exactly one document");
                      }
                    });
                    
                    ref.update({"CurrentMess": user.docs[index]["name"]}).then(
                        (value) => print("Current mess successfully updated!"),
                        onError: (e) => print("Error updating document $e"));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },
                  child: const Text("Apply for this mess")),
            ],
          ),
        ),
      ),
    );
  }
}
