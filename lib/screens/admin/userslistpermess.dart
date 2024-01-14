import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iris_app/screens/admin/dashboard.dart';

class UserList extends StatelessWidget {
  final QuerySnapshot<Object?> user;
  final int index;

  const UserList({super.key, required this.user, required this.index});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text(user.docs[index]['name']),
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
                      String mess1 = user.docs[index]['name'];
                      String mess2 = streamSnapshot.data!.docs[i]['CurrentMess'];
                      // return Text(index.toString());
                      // return Text(mess1+mess2);
                      if (mess1 == mess2) {
                        // return Text("data");
                        return GestureDetector(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(20),
                              color: Color.fromRGBO(123, 165, 255, 1),
                              child: Column(
                                children: [
                                  Text(
                                    streamSnapshot.data!.docs[i]['Name'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(streamSnapshot.data!.docs[i]['RollNo']),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashboardScreen()));
                            });
                        // return Text(streamSnapshot.data!.docs[i]['Name']+user.docs[index]['name']);
                      }
                      else{
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
