import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/services/getData.dart';

class Registration extends StatefulWidget {
  final Function togglescreen;

  const Registration({Key key, this.togglescreen}) : super(key: key);
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  List Tracks;
  List Branches;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  getData() async {
    Tracks = await Getdata().getTracks();
    // friendList.forEach((element) {});
    Branches = await Getdata().getBranches();
    if (this.mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var Firstname;
    var Lastname;
    var NID;
    var Email;
    var Password;
    var dropdownValue = 'One';
    var dropdownValue2 = 'One';
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: AppBar(
            title: Text(
              "REGISTRATION",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: HexColor("801818"),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 5),
                child: Container(
                    child: Image(
                  image: AssetImage('assets/images/iti1.png'),
                  height: 50,
                )),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                    child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  fillColor: HexColor("801818"),
                                  focusColor: HexColor("801818"),
                                  hintText: "Firstname"),
                              obscureText: false,
                              onChanged: (value) {
                                Firstname = value;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Lastname",
                                  border: UnderlineInputBorder()),
                              obscureText: false,
                              onChanged: (value) {
                                Lastname = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 8.0, right: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "National ID",
                            border: UnderlineInputBorder()),
                        obscureText: false,
                        maxLength: 14,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          NID = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Email Address",
                            border: UnderlineInputBorder()),
                        obscureText: false,
                        onChanged: (value) {
                          Email = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Password",
                            border: UnderlineInputBorder()),
                        obscureText: true,
                        onChanged: (value) {
                          Password = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          DropdownButton(
                            items: Branches.map((item) {
                              return new DropdownMenuItem(
                                child: new Text((item['data']['name'])),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                          ),
                          Container(
                            width: 150,
                            child: Column(
                              children: [
                                Text("branch"),
                                DropdownButton(
                                  value: dropdownValue2,
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownValue2 = newValue;
                                    });
                                  },
                                  items: ['One', 'Two', 'Free', 'Four']
                                      .map<DropdownMenuItem>((
                                    value,
                                  ) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 150,
                        child: Column(
                          children: [
                            Text("branch"),
                            DropdownButton(
                              value: dropdownValue2,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  dropdownValue2 = newValue;
                                });
                              },
                              items: ['One', 'Two', 'Free', 'Four']
                                  .map<DropdownMenuItem>((
                                value,
                              ) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 22),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("go to login"),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Text("Login",
                            style: TextStyle(
                                color: HexColor("801818"),
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          widget.togglescreen();
                        },
                      )
                    ])
                  ],
                )),
              )
            ],
          )),
        ));
  }
}
