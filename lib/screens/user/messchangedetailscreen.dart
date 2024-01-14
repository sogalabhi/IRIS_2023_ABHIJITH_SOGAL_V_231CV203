import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iris_app/screens/user/homescreen.dart';
import 'package:url_launcher/url_launcher.dart';

late String _url;

class MessChangeDetailScreen extends StatelessWidget {
  final QuerySnapshot<Object?> user;
  final int index;
  const MessChangeDetailScreen(
      {super.key, required this.user, required this.index});

  @override
  Widget build(BuildContext context) {
    _url = user.docs[index]["mess_link"];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mess Details"),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                user.docs[index]["name"],
                style: const TextStyle(fontSize: 20),
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
                    _launchUrl(_url);
                  },
                  child: const Text("See Menu")),
              ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("user_info")
                        .doc((FirebaseAuth.instance.currentUser!).uid)
                        .update({
                      "NextMess": user.docs[index]["name"],
                      "approved": false
                    }).then(
                            (value) =>
                                print("Current mess successfully updated!"),
                            onError: (e) =>
                                print("Error updating document $e"));

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

  Future<void> _launchUrl(String _url) async {
    int idx = _url.indexOf("/");
    if (!await launchUrl(Uri.https(_url.substring(0, idx).trim(), _url.substring(idx + 1).trim()))) {
      throw Exception('Could not launch $_url');
    }
    print(_url.substring(0, idx).trim());
  }
}
