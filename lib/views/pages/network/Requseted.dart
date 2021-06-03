import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:provider/provider.dart';

class connectRequest extends StatefulWidget {
  @override
  _connectRequestState createState() => _connectRequestState();
}

class _connectRequestState extends State<connectRequest> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final authServices = Provider.of<AuthServices>(context);
    authServices.getUserDetails(firebaseAuth.currentUser.uid);
    final userDetails = authServices.storage.getItem('uDetails');

    Stream<QuerySnapshot> _posts = FirebaseFirestore.instance
        .collection('users-details')
        .doc(firebaseAuth.currentUser.uid)
        .collection('friendRequest')
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
                      'You Have No Request Yet',
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
                    .map((e) => Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              (e.data() as Map)['avatar']),
                                          radius: 30.0,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (e.data() as Map)['firstName'] +
                                                ' ' +
                                                (e.data() as Map)['lastName'],
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            (e.data() as Map)['jobTitle'],
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 1,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('users-details')
                                              .doc(firebaseAuth.currentUser.uid)
                                              .collection('friendRequest')
                                              .doc(e.id)
                                              .delete();
                                          FirebaseFirestore.instance
                                              .collection('users-details')
                                              .doc(e.id)
                                              .collection(
                                                  'MySentfriendRequests')
                                              .doc(firebaseAuth.currentUser.uid)
                                              .delete();
                                        },
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: HexColor("801818")),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: HexColor("801818"),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('users-details')
                                              .doc(firebaseAuth.currentUser.uid)
                                              .collection('friendList')
                                              .doc(e.id)
                                              .set({
                                            'addedDate': DateTime.now(),
                                            'avatar':
                                                (e.data() as Map)['avatar'],
                                            'avatarCover': (e.data()
                                                as Map)['avatarCover'],
                                            'firstName':
                                                (e.data() as Map)['firstName'],
                                            'jobTitle':
                                                (e.data() as Map)['jobTitle'],
                                            'lastName':
                                                (e.data() as Map)['lastName'],
                                          });
                                          FirebaseFirestore.instance
                                              .collection('users-details')
                                              .doc(e.id)
                                              .collection('friendList')
                                              .doc(firebaseAuth.currentUser.uid)
                                              .set({
                                            'addedDate': DateTime.now(),
                                            'avatar': userDetails['avatar'],
                                            'avatarCover':
                                                userDetails['avatarCover'],
                                            'firstName':
                                                userDetails['firstName'],
                                            'jobTitle': userDetails['jobTitle'],
                                            'lastName': userDetails['lastName'],
                                          });
                                          Timer.periodic(
                                              new Duration(seconds: 2),
                                              (timer) {
                                            FirebaseFirestore.instance
                                                .collection('users-details')
                                                .doc(firebaseAuth
                                                    .currentUser.uid)
                                                .collection('friendRequest')
                                                .doc(e.id)
                                                .delete();
                                            FirebaseFirestore.instance
                                                .collection('users-details')
                                                .doc(e.id)
                                                .collection(
                                                    'MySentfriendRequests')
                                                .doc(firebaseAuth
                                                    .currentUser.uid)
                                                .delete();
                                          });
                                        },
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              "accept",
                                              style: TextStyle(
                                                  color: HexColor("801818")),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: HexColor("801818"),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ));
            }
          }
        });
  }
}
