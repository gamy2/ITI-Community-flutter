import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iti_community_flutter/views/widgets/profilewidgets/profileComment.dart';

class profileComments extends StatefulWidget {
  profileComments(this.postID, this.uid, this.user);
  final postID;
  final uid;
  final user;
  @override
  _profileCommentsState createState() => _profileCommentsState();
}

class _profileCommentsState extends State<profileComments> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _comments = FirebaseFirestore.instance
        .collection('users-details')
        .doc(widget.uid)
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
                              padding: const EdgeInsets.all(2.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: profileComment(
                                    e.id, e.data(), widget.uid, widget.user),
                              ),
                            ),
                          )
                          .toList()),
                ],
              );
            }
          }
        });
  }
}
