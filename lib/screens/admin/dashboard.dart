import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iris_app/screens/admin/approve_reqest.dart';
import 'package:iris_app/screens/admin/createmess.dart';
import 'package:iris_app/screens/admin/userslistpermess.dart';
import 'package:iris_app/screens/loginscreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          centerTitle: true,
          automaticallyImplyLeading: true,
          backgroundColor: const Color.fromRGBO(123, 165, 255, 1),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "List of messes",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Swipe right to delete mess",
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('mess_list')
                    .orderBy('name')
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
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(20),
                            color: const Color.fromRGBO(123, 165, 255, 1),
                            child: Column(
                              children: [
                                Text(
                                  streamSnapshot.data!.docs[index]['name'],
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text("Vacancy: " +
                                    streamSnapshot.data!.docs[index]['vacancy']
                                        .toString() +
                                    "/" +
                                    streamSnapshot.data!.docs[index]['total']
                                        .toString()),
                                Text(streamSnapshot.data!.docs[index]['type']),
                              ],
                            ),
                          ),
                          onPanUpdate: (details) {
                            if (details.delta.dx > 0) {
                              FirebaseFirestore.instance
                                  .collection('mess_list')
                                  .where("name", isEqualTo: streamSnapshot.data!.docs[index]['name'])
                                  .get()
                                  .then((value) {
                                for (DocumentSnapshot documentSnapshot
                                    in value.docs) {
                                  documentSnapshot.reference.delete();
                                }
                                value.docs.first.reference.delete();
                              });
                            }
                            if (details.delta.dx < 0) {
                              print("Y");
                            }
                          },
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserList(
                                        index: index,
                                        user: streamSnapshot.data!)));
                          });
                      // return _card(streamSnapshot.data!.docs[index]['name'], index, context);
                    },
                  );
                }),
            ElevatedButton(
              child: const Text("Approve Mess change requests"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RequestScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text("Add Mess"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateMessScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text("Logout"),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed Out");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
