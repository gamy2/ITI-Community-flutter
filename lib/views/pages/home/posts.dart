import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/views/widgets/Spinner.dart';
import 'package:iti_community_flutter/views/widgets/profilewidgets/profilePost.dart';

class Posts extends StatefulWidget {
  Posts(this.uid, this.user);
  final uid;
  final user;
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  bool isLoaded = false;
  getdata() {
    Timer.periodic(new Duration(seconds: 1), (timer) {
      isLoaded = true;
      if (this.mounted) setState(() {});
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded) {
      Stream<QuerySnapshot> _posts = FirebaseFirestore.instance
          .collection('users-details')
          .doc(widget.uid)
          .collection('MyHomePosts')
          .orderBy('PostedDate', descending: true)
          .snapshots();
      return StreamBuilder<QuerySnapshot>(
          stream: _posts,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   // return Spinner();
            // }
            if (snapshot.hasData) {
              if (snapshot.data.docs.isEmpty) {
                return Column(
                  children: [
                    Text(
                      'No Posts Yet',
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400]),
                    ),
                  ],
                );
              } else {
                {
                  return Column(
                      children: snapshot.data.docs
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: profilePost(
                                  e.id, e.data(), widget.uid, widget.user),
                            ),
                          )
                          .toList());
                }
              }
            }
          });
    } else {
      return new Container(
          color: Colors.white,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(HexColor('801818')),
                  ),
                  height: 40.0,
                  width: 40.0,
                )
              ],
            ),
          ));
    }
  }
}
