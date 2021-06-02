import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/app_localizations.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/views/pages/Settings/Settings.dart';
import 'package:iti_community_flutter/views/pages/home/posts.dart';
import 'package:iti_community_flutter/views/pages/home/writePost.dart';
import 'package:iti_community_flutter/views/pages/profile/profile.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home(this.uid, this.friendList);
  final uid;
  final friendList;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    authServices.getUserDetails(widget.uid);
    final userDetails = authServices.storage.getItem('uDetails');

    if (widget.uid == null) {
      authServices.logout();
    }

    if (isLoaded) {
      return Scaffold(
        body: Container(
          color: HexColor("801818"),
          child: SafeArea(
            child: Container(
              color: HexColor("e4e1e1"),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height: 58,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Profile(widget.uid)));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(userDetails["avatar"]),
                                      radius: 30.0,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => writePost(
                                                widget.uid,
                                                userDetails,
                                                widget.friendList)));
                                  },
                                  child: SizedBox(
                                    width: 65,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DecoratedBox(
                                          child: Center(
                                              child: Text("+",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20))),
                                          decoration: BoxDecoration(
                                            color: HexColor("e4e1e1"),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 58,
                                  child: InkWell(
                                      child: Icon(Icons.settings),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => settings(),
                                            ));
                                      }),
                                )
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Posts(widget.uid, userDetails)
                  ],
                ),
              ),
            ),
          ),
        ),
      );
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
