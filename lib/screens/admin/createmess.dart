import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iris_app/widgets/allwidgets.dart';

class CreateMessScreen extends StatelessWidget {
  // const CreateMessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameTextController = TextEditingController();
    TextEditingController _totalseatTextController = TextEditingController();
    TextEditingController _menulinkTextController = TextEditingController();
    TextEditingController _typeTextController = TextEditingController();
    FirebaseFirestore db = FirebaseFirestore.instance;

    return SafeArea(
      child: Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 52, 1, 141),
            ),
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Mess Name", Icons.person_outline,
                      false, _nameTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Total seats", Icons.person_outline,
                      false, _totalseatTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Veg/Non veg", Icons.lock_outlined,
                      false, _typeTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Mess menu pdf link", Icons.lock_outlined,
                      false, _menulinkTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  firebaseUIButton(context, "Add mess", () {
                    final mess = <String, dynamic>{
                      "name": _nameTextController.text,
                      "vacancy": 0,
                      "total": _totalseatTextController.text,
                      "mess_link": _menulinkTextController.text,
                      "type": _typeTextController.text
                    };
                    db.collection("mess_list").add(mess).then(
                          (DocumentReference doc) => print(
                              'DocumentSnapshot added with ID: ${doc.id}'),
                        );
                  })
                ],
              ),
            ))),
      ),
    );
  }
}
