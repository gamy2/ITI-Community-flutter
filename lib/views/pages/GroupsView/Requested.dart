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
    final belal = Provider.of<AuthServices>(context);
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          InkWell(
            child: Text('Belala'),
            onTap: () {
              // belal.logout();
              // var s = AuthServices.store.getItem('uid');
              var s = AuthServices.userID;
            },
          ),
        ],
      )),
    );
  }
}
