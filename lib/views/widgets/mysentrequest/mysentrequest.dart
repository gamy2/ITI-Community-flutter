import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/views/pages/profile/profile.dart';
import 'package:provider/provider.dart';

class mySentRequest extends StatefulWidget {
  mySentRequest(this.data, this.userRequestId);
  final data;
  final userRequestId;
  @override
  _mySentRequestState createState() => _mySentRequestState();
}

class _mySentRequestState extends State<mySentRequest> {
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
    final authServices = Provider.of<AuthServices>(context);
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    // authServices.getDataById(widget.uid);
    // var userDetails = authServices.storage.getItem("clickedDetails");
    if (!isLoaded) {
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
    } else {
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.data['avatar']),
                          radius: 30.0,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (widget.data['firstName']),
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.data['jobTitle'],
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(widget.data['id'])));
                  },
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
                            .collection('MySentfriendRequests')
                            .doc(widget.userRequestId)
                            .delete();
                        FirebaseFirestore.instance
                            .collection('users-details')
                            .doc(widget.userRequestId)
                            .collection('friendRequest')
                            .doc(firebaseAuth.currentUser.uid)
                            .delete();
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Cancel",
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
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      );
    }
  }
}
