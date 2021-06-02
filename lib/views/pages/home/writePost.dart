import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class writePost extends StatefulWidget {
  writePost(this.uid, this.userDetails, this.friendList);
  final userDetails;
  final uid;
  List friendList;
  @override
  _writePostState createState() => _writePostState();
}

class _writePostState extends State<writePost> {
  TextEditingController _postcontroller;

  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _postcontroller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _postcontroller.dispose();

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
                      Text("Write a Post!",
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
                            controller: _postcontroller,
                            validator: (val) =>
                                val.isNotEmpty ? null : "Wlease Write Post",
                            decoration: InputDecoration(
                                hintText: "Post",
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
                                  child: Text("Post It Now",
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
                                    .doc(widget.uid)
                                    .collection('MyHomePosts')
                                    .add({
                                  'Auther': {
                                    'avatar': widget.userDetails['avatar'],
                                    'firstName':
                                        widget.userDetails['firstName'],
                                    'lastName': widget.userDetails['lastName'],
                                    'jobTitle': widget.userDetails['jobTitle'],
                                    'id': widget.uid
                                  },
                                  'Body': _postcontroller.text,
                                  'Likes': [],
                                  'PostedDate': DateTime.now(),
                                  'postID': '',
                                  'postImg': [],
                                  'savedState': false
                                });

                                await widget.friendList.forEach((e) {
                                  FirebaseFirestore.instance
                                      .collection('users-details')
                                      .doc(e)
                                      .collection('MyHomePosts')
                                      .doc(pid.id)
                                      .set({
                                    'Auther': {
                                      'avatar': widget.userDetails['avatar'],
                                      'firstName':
                                          widget.userDetails['firstName'],
                                      'lastName':
                                          widget.userDetails['lastName'],
                                      'jobTitle':
                                          widget.userDetails['jobTitle'],
                                      'id': widget.uid
                                    },
                                    'Body': _postcontroller.text,
                                    'Likes': [],
                                    'PostedDate': DateTime.now(),
                                    'postID': '',
                                    'postImg': [],
                                    'savedState': false
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
