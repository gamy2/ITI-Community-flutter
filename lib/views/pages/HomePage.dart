import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: InkWell(
          child: Text("Logout!"),
          onTap: () {
            loginProvider.logout();
          },
        ),
      ),
    ));
  }
}
