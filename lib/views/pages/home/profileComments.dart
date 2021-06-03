import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/services/getData.dart';
import 'package:iti_community_flutter/views/pages/home/writeComment.dart';
import 'package:iti_community_flutter/views/widgets/profilewidgets/profileComment.dart';

class profileComments extends StatefulWidget {
  profileComments(this.autherId, this.postID, this.myuid, this.user);
  final postID;
  final myuid;
  final user;
  final autherId;
  @override
  _profileCommentsState createState() => _profileCommentsState();
}

class _profileCommentsState extends State<profileComments> {
  List<String> friendList;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  getData() async {
    friendList = await Getdata().getFriendList(widget.autherId);
    // friendList.forEach((element) {});
    if (this.mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _comments = FirebaseFirestore.instance
        .collection('users-details')
        .doc(widget.myuid)
        .collection('MyHomePosts')
        .doc(widget.postID)
        .collection('postsComments')
        .orderBy('CommentDate')
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _comments,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return Spinner();
          }
          if (snapshot.hasData) {
            if (snapshot.data.docs.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'No Comments Yet',
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400]),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => writeComment(
                                    widget.autherId,
                                    widget.postID,
                                    widget.myuid,
                                    widget.user,
                                    friendList)));
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Leave The First Comment...",
                            style: TextStyle(color: HexColor("801818")),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: HexColor("801818"),
                            width: 1,
                          ),
                        ),
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "comments",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800]),
                    ),
                  ),
                  Column(
                      children: snapshot.data.docs
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: profileComment(
                                  e.id, e.data(), widget.myuid, widget.user),
                            ),
                          )
                          .toList()),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => writeComment(
                                  widget.autherId,
                                  widget.postID,
                                  widget.myuid,
                                  widget.user,
                                  friendList)));
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Leave a Comment...",
                          style: TextStyle(color: HexColor("801818")),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: HexColor("801818"),
                          width: 1,
                        ),
                      ),
                      width: double.infinity,
                    ),
                  ),
                ],
              );
            }
          }
        });
  }
}
