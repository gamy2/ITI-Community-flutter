import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:iti_community_flutter/main.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/views/pages/Settings/Settings.dart';
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
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    authServices.getDataById(widget.clickedID);
    final userDetails = authServices.storage.getItem("clickedDetails");
    if (userDetails == null) {
      authServices.logout();
    }
    print(userDetails);

    return Scaffold(
      body: Container(
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
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                              onTap: () {
                                print(userDetails);
                              },
                            ),
                            InkWell(
                                child: Icon(Icons.settings),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Settings(),
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
              profileExp()
            ],
          ),
        )),
      ),
    );
  }
}
