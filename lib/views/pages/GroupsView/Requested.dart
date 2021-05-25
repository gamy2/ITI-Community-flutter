import 'package:flutter/material.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:provider/provider.dart';

class RequestedGroups extends StatefulWidget {
  @override
  _RequestedGroupsState createState() => _RequestedGroupsState();
}

class _RequestedGroupsState extends State<RequestedGroups> {
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final userid = authServices.storage.getItem('uid');
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          InkWell(
            child: Text('Requested Groups'),
            onTap: () {},
          ),
        ],
      )),
    );
  }
}
