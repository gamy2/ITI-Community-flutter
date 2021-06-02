import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iti_community_flutter/views/widgets/mysentrequest/mysentrequest.dart';

class myRquest extends StatefulWidget {
  @override
  _myRquestState createState() => _myRquestState();
}

class _myRquestState extends State<myRquest> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    Stream<QuerySnapshot> _posts = FirebaseFirestore.instance
        .collection('users-details')
        .doc(firebaseAuth.currentUser.uid)
        .collection('MySentfriendRequests')
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _posts,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   // return Spinner();
          // }
          if (snapshot.hasData) {
            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You Didn't Sent Request Yet",
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400]),
                    ),
                  ],
                ),
              );
            } else {
              return SingleChildScrollView(
                  child: Column(
                      children: snapshot.data.docs
                          .map((e) => mySentRequest(e.data(), e.id))
                          .toList()));
            }
          }
        });
  }
}
