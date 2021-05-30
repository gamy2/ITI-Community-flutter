import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _firstName;
  TextEditingController _lastName;
  TextEditingController _jobTitle;
  TextEditingController _about;
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _jobTitle = TextEditingController();
    _about = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _about.dispose();
    _jobTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    authServices.getDataById(AuthServices.userID);
    final userDetails = authServices.storage.getItem("clickedDetails");
    CollectionReference users =
        FirebaseFirestore.instance.collection('users-details');
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
                                      ])))),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                controller: _firstName,
                                validator: (val) => val.isNotEmpty
                                    ? null
                                    : "please enter firstName",
                                decoration: InputDecoration(
                                    hintText: "Firstname",
                                    prefixIcon: Icon(Icons.people)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                controller: _lastName,
                                validator: (val) => val.isNotEmpty
                                    ? null
                                    : "please enter lastName",
                                decoration: InputDecoration(
                                    hintText: "Lastname",
                                    prefixIcon: Icon(Icons.people)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                controller: _jobTitle,
                                validator: (val) => val.isNotEmpty
                                    ? null
                                    : "please enter your JobTitle",
                                decoration: InputDecoration(
                                    hintText: "JobTitle",
                                    prefixIcon: Icon(Icons.people)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                controller: _about,
                                // validator: (val) => val.isNotEmpty
                                //     ? null
                                //     : "please enter your about",
                                decoration: InputDecoration(
                                    hintText: "about",
                                    prefixIcon: Icon(Icons.people)),
                              ),
                            ),
                            InkWell(
                              child: SizedBox(
                                width: 300,
                                height: 40,
                                child: Card(
                                  color: HexColor("801818"),
                                  child: Center(
                                    child: Text("Sing In",
                                        style: TextStyle(
                                            color: HexColor("e4e1e1"),
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                              onTap: () {
                                if (_formkey.currentState.validate()) {
                                  users
                                      .doc(AuthServices.userID)
                                      .update({
                                        'firstName': _firstName.text.trim(),
                                        'lastName': _lastName.text.trim(),
                                        'jobTitle': _jobTitle.text.trim(),
                                        'about': _about.text.trim()
                                      })
                                      .then((value) => print("User Updated"))
                                      .catchError((error) => print(
                                          "Failed to update user: $error"));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ])))));
  }
}
