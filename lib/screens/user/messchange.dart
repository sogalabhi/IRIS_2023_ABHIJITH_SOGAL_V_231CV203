import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iris_app/screens/user/messchangedetailscreen.dart';
import 'package:iris_app/screens/user/messdetailsscreen.dart';
import 'package:iris_app/utils/model.dart';

class MessChangeScreen extends StatefulWidget {
  const MessChangeScreen({super.key});

  @override
  State<MessChangeScreen> createState() => _MessChangeScreenState();
}

class _MessChangeScreenState extends State<MessChangeScreen> {
  String? _currentMess;
  @override
  void initState() {
    super.initState();
    _getMessName();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("List of messes"),
        ),
        body: Column(
          children: [
            SizedBox(height: 10,),
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
                  // return Text(streamSnapshot.data!.docs.length.toString());
                  return ListView.builder(
                    itemCount: streamSnapshot.data?.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      if (_currentMess !=
                          streamSnapshot.data!.docs[index]['name']) {
                        return GestureDetector(
                            child: Container(
                              margin: EdgeInsets.all(2),
                              padding: EdgeInsets.all(20),
                              color: Colors.amber,
                              child: Column(
                                children: [
                                  Text(
                                    streamSnapshot.data!.docs[index]['name'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text("Vacancy: " +
                                      streamSnapshot
                                          .data!.docs[index]['vacancy']
                                          .toString() +
                                      "/" +
                                      streamSnapshot.data!.docs[index]['total']
                                          .toString()),
                                  Text(
                                      streamSnapshot.data!.docs[index]['type']),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MessChangeDetailScreen(
                                          index: index,
                                          user: streamSnapshot.data!)));
                            });
                      } else {
                        return Container();
                      }
                      // return _card(streamSnapshot.data!.docs[index]['name'], index, context);
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  Future<void> _getMessName() async {
    FirebaseFirestore.instance
        .collection('user_info')
        .doc((FirebaseAuth.instance.currentUser!).uid)
        .get()
        .then((value) {
      setState(() {
        _currentMess = value.data()!['CurrentMess'].toString();
        print(_currentMess);
      });
    });
  }
}

// Widget _card(List<QueryDocumentSnapshot<>> user, int index, BuildContext context) {
//   return GestureDetector(
//       child: Container(
//         margin: EdgeInsets.all(10),
//         padding: EdgeInsets.all(20),
//         color: Colors.amber,
//         child: Column(
//           children: [
//             Text(
//               user[index].name,
//               style: const TextStyle(fontSize: 20),
//             ),
//             Text("Vacancy: " +
//                 user[index].vacancy +
//                 "/" +
//                 user[index].totalseat),
//             Text(user[index].type),
//           ],
//         ),
//       ),
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     MessDetailsScreen(index: index, user: user)));
//       });
// }
