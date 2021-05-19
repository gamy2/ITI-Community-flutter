import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Groups extends StatefulWidget {
  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Groups'),
        backgroundColor: HexColor("801818"),
      ),
      body: SafeArea(
        child: Center(
          child: Text('Group'),
        ),
      ),
    );
  }
}
