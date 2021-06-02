import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class writeComment extends StatefulWidget {
  writeComment(
      this.autherId, this.postId, this.uid, this.userDetails, this.friendList);
  final userDetails;
  final uid;
  List friendList;
  final postId;
  final autherId;
  @override
  _writeCommentState createState() => _writeCommentState();
}

class _writeCommentState extends State<writeComment> {
  TextEditingController _commentcontroller;

  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _commentcontroller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _commentcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor("801818"),
        child: SafeArea(
          child: Form(
            key: _formkey,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 20,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                        SizedBox(width: 20),
                        SizedBox(width: 20)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Write a Comment!",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      SizedBox(height: 40),
                      Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 8,
                            maxLength: 1000,
                            controller: _commentcontroller,
                            validator: (val) =>
                                val.isNotEmpty ? null : "Wlease Write Post",
                            decoration: InputDecoration(
                                hintText: "comment",
                                prefixIcon: Icon(Icons.post_add),
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            child: SizedBox(
                              width: 300,
                              height: 40,
                              child: Card(
                                color: HexColor("801818"),
                                child: Center(
                                  child: Text("Leave a Comment",
                                      style: TextStyle(
                                          color: HexColor("e4e1e1"),
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            onTap: () async {
                              if (_formkey.currentState.validate()) {
                                var pid = await FirebaseFirestore.instance
                                    .collection('users-details')
                                    .doc(widget.autherId)
                                    .collection('MyHomePosts')
                                    .doc(widget.postId)
                                    .collection('postsComments')
                                    .add({
                                  'Body': _commentcontroller.text,
                                  'CommentDate': DateTime.now(),
                                  'User': {
                                    'avatar': widget.userDetails['avatar'],
                                    'firstName':
                                        widget.userDetails['firstName'],
                                    'jobTitle': widget.userDetails['jobTitle'],
                                    'lastName': widget.userDetails['lastName'],
                                    'id': widget.uid
                                  }
                                });

                                await widget.friendList.forEach((e) {
                                  FirebaseFirestore.instance
                                      .collection('users-details')
                                      .doc(e)
                                      .collection('MyHomePosts')
                                      .doc(widget.postId)
                                      .collection('postsComments')
                                      .doc(pid.id)
                                      .set({
                                    'Body': _commentcontroller.text,
                                    'CommentDate': DateTime.now(),
                                    'User': {
                                      'avatar': widget.userDetails['avatar'],
                                      'firstName':
                                          widget.userDetails['firstName'],
                                      'jobTitle':
                                          widget.userDetails['jobTitle'],
                                      'lastName':
                                          widget.userDetails['lastName'],
                                      'id': widget.uid
                                    }
                                  });
                                  print(e);
                                });

                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
