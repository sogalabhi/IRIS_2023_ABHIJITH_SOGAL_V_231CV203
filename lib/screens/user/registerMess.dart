import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iris_app/screens/user/messdetailsscreen.dart';

class MessRegistrationScreen extends StatefulWidget {
  const MessRegistrationScreen({super.key});

  @override
  State<MessRegistrationScreen> createState() => _MessRegistrationScreenState();
}

class _MessRegistrationScreenState extends State<MessRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Text("List of messes"),
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
                  // return Text(streamSnapshot.data!.docs.length.toString());
                  return ListView.builder(
                    itemCount: streamSnapshot.data?.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(20),
                            color: Colors.amber,
                            child: Column(
                              children: [
                                Text(
                                  streamSnapshot.data!.docs[index]['name'],
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text("Vacancy: " +
                                    streamSnapshot.data!.docs[index]
                                        ['vacancy'].toString() +
                                    "/" +
                                    streamSnapshot.data!.docs[index]['total'].toString()),
                                Text(streamSnapshot.data!.docs[index]['type']),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MessDetailsScreen(
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
