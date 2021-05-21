import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/views/pages/Settings/Settings.dart';

class Profile extends StatefulWidget {
  Profile(this.userDetails);
  final userDetails;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
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
                          children: [
                            InkWell(
                                child: Icon(Icons.arrow_back),
                                onTap: () {
                                  Navigator.pop(context);
                                }),
                            SizedBox(
                              width: 350,
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
                      )))
            ],
          ),
        )),
      ),
    );
  }
}
