import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    authServices.getDataById(AuthServices.userID);
    final userDetails = authServices.storage.getItem("clickedDetails");
    if (userDetails == null) {
      authServices.logout();
    }

    return Scaffold(
        body: Container(
            color: HexColor("801818"),
            child: SafeArea(
                child: Container(
                    color: HexColor("e4e1e1"),
                    child: Column(children: [
                      SizedBox(
                          height: 58,
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.white),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                        SizedBox(
                                          width: 2,
                                        )
                                      ]))))
                    ])))));
  }
}
