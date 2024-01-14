import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iris_app/screens/loginscreen.dart';
import 'package:iris_app/screens/user/messchange.dart';
import 'package:iris_app/screens/user/registerMess.dart';
import 'package:iris_app/utils/network_aware_widget.dart';
import 'package:iris_app/utils/network_status_service.dart';
import 'package:iris_app/widgets/allwidgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userName;
  @override
  void initState() {
    super.initState();
    _getUserName();
    // openbox();
  }

  Future<void> openbox() async {}

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String? userEmail = auth.currentUser!.email;

    // var box = Hive.box('box_name');

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('user_info')
                  .doc((FirebaseAuth.instance.currentUser!).uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text("Loading");
                }
                var userDocument = snapshot.data;

                // box.put('name', userDocument!['Name']);
                // box.put('email', userEmail!);
                // box.put('rollno', userDocument['RollNo']);
                // box.put('messbalance', userDocument['MessBalance']);
                // box.put('currentMess', userDocument['CurrentMess'] ?? '');
                // box.put('NextMess', userDocument['NextMess'] ?? '');

                return Column(
                  children: [
                    logoWidget(
                        "https://e7.pngegg.com/pngimages/178/595/png-clipart-user-profile-computer-icons-login-user-avatars-monochrome-black.png"),
                    const SizedBox(height: 20),
                    Text(
                      userDocument!['Name'],
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(userEmail!),
                    const SizedBox(height: 10),
                    Text(userDocument['RollNo']),
                    const SizedBox(height: 10),
                    Text("Mess Balance: " + userDocument['MessBalance']),
                    const SizedBox(height: 10),
                    Builder(builder: (context) {
                      if (userDocument['NextMess'] == "") {
                        return Container();
                      } else {
                        return Column(
                          children: [
                            Text("Applied mess = " +
                                userDocument['NextMess'] +
                                ", process pending"),
                            const SizedBox(height: 10),
                          ],
                        );
                      }
                    }),
                    Builder(builder: (context) {
                      if (userDocument['CurrentMess'] != "") {
                        String messName = userDocument['CurrentMess'];
                        return Column(
                          children: [
                            Text(
                                "Current Mess: " + userDocument['CurrentMess']),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MessChangeScreen(),
                                  ),
                                );
                              },
                              child: const Text("Change mess"),
                            ),
                          ],
                        );
                      } else {
                        return ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MessRegistrationScreen()));
                            },
                            child: const Text("Register for mess"));
                      }
                    }),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      child: Text("Logout"),
                      onPressed: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          print("Signed Out");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        });
                      },
                    ),
                  ],
                );

                // return StreamProvider<NetworkStatus>(
                //   create: (context) =>
                //       NetworkStatusService().networkStatusController.stream,
                //   initialData: NetworkStatus.Offline,
                //   child: NetworkAwareWidget(
                //     offlineChild: Column(
                //       children: [
                //         Text(
                //           userDocument!['Name'],
                //           style: const TextStyle(fontSize: 20),
                //         ),
                //         const SizedBox(height: 10),
                //         Text(userEmail!),
                //         const SizedBox(height: 10),
                //         Text(userDocument['RollNo']),
                //         const SizedBox(height: 10),
                //         Text("Mess Balance: " + userDocument['MessBalance']),
                //         const SizedBox(height: 10),
                //         Builder(builder: (context) {
                //           if (userDocument['NextMess'] == "") {
                //             return Container();
                //           } else {
                //             return Column(
                //               children: [
                //                 Text("Applied mess = " +
                //                     userDocument['NextMess']),
                //                 const SizedBox(height: 10),
                //               ],
                //             );
                //           }
                //         }),
                //       ],
                //     ),
                //     onlineChild: Column(
                //       children: [
                //         logoWidget(
                //             "https://e7.pngegg.com/pngimages/178/595/png-clipart-user-profile-computer-icons-login-user-avatars-monochrome-black.png"),
                //         const SizedBox(height: 20),
                //         Text(
                //           userDocument!['Name'],
                //           style: const TextStyle(fontSize: 20),
                //         ),
                //         const SizedBox(height: 10),
                //         Text(userEmail!),
                //         const SizedBox(height: 10),
                //         Text(userDocument['RollNo']),
                //         const SizedBox(height: 10),
                //         Text("Mess Balance: " + userDocument['MessBalance']),
                //         const SizedBox(height: 10),
                //         Builder(builder: (context) {
                //           if (userDocument['NextMess'] == "") {
                //             return Container();
                //           } else {
                //             return Column(
                //               children: [
                //                 Text("Applied mess = " +
                //                     userDocument['NextMess'] +
                //                     ", process pending"),
                //                 const SizedBox(height: 10),
                //               ],
                //             );
                //           }
                //         }),
                //         Builder(builder: (context) {
                //           if (userDocument['CurrentMess'] != "") {
                //             String messName = userDocument['CurrentMess'];
                //             return Column(
                //               children: [
                //                 Text("Current Mess: " +
                //                     userDocument['CurrentMess']),
                //                 const SizedBox(height: 10),
                //                 ElevatedButton(
                //                   onPressed: () {
                //                     Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                //                         builder: (context) =>
                //                             MessChangeScreen(),
                //                       ),
                //                     );
                //                   },
                //                   child: const Text("Change mess"),
                //                 ),
                //               ],
                //             );
                //           } else {
                //             return ElevatedButton(
                //                 onPressed: () {
                //                   Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                //                           builder: (context) =>
                //                               const MessRegistrationScreen()));
                //                 },
                //                 child: const Text("Register for mess"));
                //           }
                //         }),
                //         const SizedBox(height: 10),
                //         ElevatedButton(
                //           child: Text("Logout"),
                //           onPressed: () {
                //             FirebaseAuth.instance.signOut().then((value) {
                //               print("Signed Out");
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) => SignInScreen()));
                //             });
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                // );
              }),
        ),
      ),
    );
  }

  Future<void> _getUserName() async {
    FirebaseFirestore.instance
        .collection('user_info')
        .doc((FirebaseAuth.instance.currentUser!).uid)
        .get()
        .then((value) {
      setState(() {
        _userName = value.data()!['Name'].toString();
      });
    });
  }
}
