import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iris_app/screens/user/homescreen.dart';

class UserManagement {
  storeNewUser(user, context) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance
        .collection("user_info")
        .doc(firebaseUser.uid)
        .set({'email': user.email, 'uid': user.uid}).
        then((value) => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen())))
        .catchError((e){
          print(e);
        });
  }
}
