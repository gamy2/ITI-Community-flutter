import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:iti_community_flutter/main.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/views/pages/Settings/Settings.dart';
import 'package:iti_community_flutter/views/pages/profile/editProfile.dart';
import 'package:iti_community_flutter/views/widgets/profilewidgets/profileAbout.dart';
import 'package:iti_community_flutter/views/widgets/profilewidgets/profileExp.dart';

import 'package:iti_community_flutter/views/widgets/profilewidgets/proflieDetails.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile(this.clickedID);
  final clickedID;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

// @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);

    authServices.getDataById(widget.clickedID);
    var userDetails = authServices.storage.getItem("clickedDetails");

    // Timer.periodic(new Duration(seconds: 1), (timer) {
    //   if (userDetails == null) {
    //     authServices.logout();
    //   }
    // });
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
      return new Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: HexColor("801818"),
            child: SafeArea(
                child: Container(
              color: HexColor("e4e1e1"),
              child: Column(
                children: [
                  SizedBox(
                      height: 58,
                      child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    child: Icon(Icons.arrow_back),
                                    onTap: () {
                                      Navigator.pop(context);
                                    }),
                                InkWell(
                                  child: Center(
                                      child: Text(
                                    userDetails["firstName"] +
                                        " " +
                                        userDetails["lastName"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )),
                                  onTap: () {
                                    print(userDetails);
                                  },
                                ),
                                InkWell(
                                    child: Icon((widget.clickedID !=
                                            AuthServices.userID)
                                        ? Icons.settings
                                        : Icons.edit),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ((widget.clickedID !=
                                                        AuthServices.userID)
                                                    ? settings()
                                                    : EditProfile()),
                                          ));
                                    })
                              ],
                            ),
                          ))),
                  Profiledetails(
                      userDetails["avatar"],
                      userDetails["avatarCover"],
                      userDetails["firstName"],
                      userDetails["lastName"],
                      userDetails["jobTitle"]),
                  SizedBox(
                    height: 20,
                  ),
                  profileAbout(userDetails["about"]),
                  SizedBox(
                    height: 20,
                  ),
                  profileExp(userDetails['experiences'], widget.clickedID)
                ],
              ),
            )),
          ),
        ),
      );
    }
  }
}
