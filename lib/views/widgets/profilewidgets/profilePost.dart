import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iti_community_flutter/services/getData.dart';
import 'package:iti_community_flutter/views/pages/home/profileComments.dart';
import 'package:iti_community_flutter/views/pages/profile/profile.dart';

class profilePost extends StatefulWidget {
  profilePost(this.id, this.data, this.uid, this.user);
  final id;
  final data;
  final uid;
  final user;
  @override
  _profilePostState createState() => _profilePostState();
}

class _profilePostState extends State<profilePost> {
  List<String> friendList;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  getData() async {
    friendList = await Getdata().getFriendList(widget.data['Auther']['id']);
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
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          (widget.data["Auther"]['avatar'] != null
              ? InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(widget.data["Auther"]['avatar']),
                              radius: 30.0,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data["Auther"]['firstName'] +
                                    ' ' +
                                    widget.data["Auther"]['lastName'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.data["Auther"]['jobTitle'])
                            ],
                          )
                        ],
                      ),
                      (widget.data['Auther']['id'] ==
                              firebaseAuth.currentUser.uid
                          ? Row(
                              children: [
                                // InkWell(
                                //   onTap: () {
                                //     print('ok');
                                //   },
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Container(
                                //         child: SizedBox(
                                //             width: 20,
                                //             height: 20,
                                //             child: Icon(Icons.edit))),
                                //   ),
                                // ),
                                InkWell(
                                  onTap: () async {
                                    await friendList.forEach((e) {
                                      FirebaseFirestore.instance
                                          .collection('users-details')
                                          .doc(e)
                                          .collection('MyHomePosts')
                                          .doc(widget.id)
                                          .delete();
                                      print(e);
                                    });
                                    await Timer.periodic(
                                        new Duration(seconds: 2), (timer) {
                                      FirebaseFirestore.instance
                                          .collection('users-details')
                                          .doc(widget.data['Auther']['id'])
                                          .collection('MyHomePosts')
                                          .doc(widget.id)
                                          .delete();
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Icon(Icons.delete))),
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                )
                              ],
                            )
                          : Text(" "))
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(
                                (widget.data['Auther']['id'] != null
                                    ? widget.data['Auther']['id']
                                    : ''))));
                  },
                )
              : Text(' ')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.data["Body"]),
          ),
          widget.data['postImg'] != ''
              ? Wrap(
                  alignment: WrapAlignment.start,
                  children: widget.data['postImg']
                      .map<Widget>((imgUrl) => SizedBox(
                            height: 100,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image: NetworkImage(imgUrl),
                                height: 80,
                              ),
                            ),
                          ))
                      .toList())
              : Text(' '),
          profileComments(
              widget.data['Auther']['id'], widget.id, widget.uid, widget.user),
        ],
      ),
    );
  }
}
