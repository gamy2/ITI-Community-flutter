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
    var index = 5;
    if (isLoaded) {
      Stream<QuerySnapshot> _posts = FirebaseFirestore.instance
          .collection('users-details')
          .doc(widget.uid)
          .collection('MyHomePosts')
          .orderBy('PostedDate', descending: true)
          .limit(index)
          .snapshots();
      return StreamBuilder<QuerySnapshot>(
          stream: _posts,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (!snapshot.hasData) {
              // show loading while waiting for real data
              return Text(" ");
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
                    children: [
                      Column(
                          children: snapshot.data.docs
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: profilePost(
                                      e.id, e.data(), widget.uid, widget.user),
                                ),
                              )
                              .toList()),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "More",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: HexColor("801818"),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                            ),
                            onTap: () {
                              var nextIndex = index + 10;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => fullPosts(
                                          widget.uid, widget.user, nextIndex)));
                            },
                          ))
                    ],
                  );
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

class fullPosts extends StatefulWidget {
  fullPosts(this.uid, this.user, this.index);
  final uid;
  final user;
  final index;
  @override
  _fullPostsState createState() => _fullPostsState();
}

class _fullPostsState extends State<fullPosts> {
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
          // .limit(widget.index)
          .snapshots();
      return StreamBuilder<QuerySnapshot>(
          stream: _posts,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (!snapshot.hasData) {
              // show loading while waiting for real data
              return CircularProgressIndicator();
            }
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   // return Spinner();
            // }
            if (snapshot.hasData) {
              if (snapshot.data.docs.isEmpty) {
                return Scaffold(
                  body: Column(
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
                  ),
                );
              } else {
                {
                  return Scaffold(
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Icon(Icons.arrow_back),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            Column(
                                children: snapshot.data.docs
                                    .map(
                                      (e) => Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: profilePost(e.id, e.data(),
                                            widget.uid, widget.user),
                                      ),
                                    )
                                    .toList()),
                            // Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: InkWell(
                            //       child: Container(
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(10.0),
                            //           child: Text(
                            //             "More",
                            //             style: TextStyle(color: Colors.white),
                            //           ),
                            //         ),
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(10),
                            //           color: HexColor("801818"),
                            //           border: Border.all(
                            //             color: Colors.white,
                            //             width: 1,
                            //           ),
                            //         ),
                            //       ),
                            //       onTap: () {
                            //         var nextIndex = widget.index + 10;
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (context) => fullPosts(
                            //                     widget.uid,
                            //                     widget.user,
                            //                     nextIndex)));
                            //       },
                            //     ))
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
            }
          });
    } else {
      return Scaffold(
        body: new Container(
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
            )),
      );
    }
  }
}
