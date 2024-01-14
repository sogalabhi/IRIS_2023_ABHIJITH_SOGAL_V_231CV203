import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iris_app/screens/admin/request_user_list.dart';
import 'package:iris_app/screens/admin/userslistpermess.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mess change requests"),
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
              "Requests to messes",
              style: TextStyle(fontSize: 20),
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
                                // Text(
                                //   "Number of requests: "+streamSnapshot.data!.docs[index]['requests'].toString(),
                                // ),
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RequestUserList(
                                        index: index,
                                        user: streamSnapshot.data!)));
                          });
                      // return _card(streamSnapshot.data!.docs[index]['name'], index, context);
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
