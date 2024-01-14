import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iris_app/screens/admin/dashboard.dart';

class RequestUserList extends StatelessWidget {
  final QuerySnapshot<Object?> user;
  final int index;

  const RequestUserList({super.key, required this.user, required this.index});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Text("Click on the user to approve"),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('user_info')
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasError) {
                    return const Text("Has error");
                  }
                  if (streamSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Text("Loading....");
                  }
                  return ListView.builder(
                    itemCount: streamSnapshot.data?.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int i) {
                      String messprevscreen = user.docs[index]['name'];
                      String newmessdoc = user.docs[index].reference.id;
                      String currentmess =
                          streamSnapshot.data!.docs[i]['CurrentMess'];
                      String nextMess =
                          streamSnapshot.data!.docs[i]['NextMess'];

                      bool approved = streamSnapshot.data!.docs[i]['approved'];
                      final docid = streamSnapshot.data!.docs[i].reference.id;
                      if (messprevscreen == nextMess && !approved) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(20),
                          color: const Color.fromRGBO(123, 165, 255, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    streamSnapshot.data!.docs[i]['Name'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(streamSnapshot.data!.docs[i]['RollNo']),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    child: const Icon(Icons.check),
                                    onTap: () {
                                      FirebaseFirestore.instance
                                          .collection("mess_list")
                                          .where('name', isEqualTo: currentmess)
                                          .get()
                                          .then((value) {
                                        if (value.size == 1) {
                                          final currentmesssnap = value.docs[0];
                                          print(currentmesssnap.reference.id);

                                          int currentV =
                                              currentmesssnap['vacancy'];
                                          print(currentV.toString());

                                          FirebaseFirestore.instance
                                              .collection("mess_list")
                                              .doc(currentmesssnap.reference.id)
                                              .update({
                                            "vacancy": currentV - 1
                                          }).then(
                                                  (value) => print(
                                                      "$currentV currentv successfully updated!"),
                                                  onError: (e) => print(
                                                      "Error updating document $e"));

                                          int nextmessV =
                                              user.docs[index]['vacancy'];

                                          FirebaseFirestore.instance
                                              .collection("mess_list")
                                              .doc(newmessdoc)
                                              .update({
                                            "vacancy": nextmessV + 1
                                          }).then(
                                                  (value) => print((nextmessV +
                                                              1)
                                                          .toString() +
                                                      " nextv successfully updated!"),
                                                  onError: (e) => print(
                                                      "Error updating document $e"));
                                        } else {
                                          print(
                                              "query result in exactly one document");
                                        }
                                      });
                                      FirebaseFirestore.instance
                                          .collection("user_info")
                                          .doc(docid)
                                          .update({
                                        "CurrentMess": nextMess,
                                        "NextMess": "",
                                        "approved": true
                                      }).then(
                                              (value) => print(
                                                  "Current mess successfully updated!"),
                                              onError: (e) => print(
                                                  "Error updating document $e"));

                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => DashboardScreen()));
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    child: const Icon(Icons.clear),
                                    onTap: () {
                                      
                                      FirebaseFirestore.instance
                                          .collection("user_info")
                                          .doc(docid)
                                          .update({
                                        "NextMess": "",
                                        "approved": true
                                      }).then(
                                              (value) => print(
                                                  "Current mess successfully updated!"),
                                              onError: (e) => print(
                                                  "Error updating document $e"));

                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => DashboardScreen()));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                        // return Text(streamSnapshot.data!.docs[i]['Name']+user.docs[index]['name']);
                      } else {
                        return Container();
                      }
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
