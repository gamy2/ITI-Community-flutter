import 'package:flutter/material.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:provider/provider.dart';

class Network extends StatefulWidget {
  Network(this.uid, this.user);
  final uid;
  var user;

  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: Column(
      children: [
        InkWell(
          child: Text('user'),
          onTap: () {
            print(widget.user.toString());
          },
        ),
        InkWell(
          child: Text('id'),
          onTap: () {
            print(widget.uid.toString());
          },
        ),
      ],
    )));
  }
}
