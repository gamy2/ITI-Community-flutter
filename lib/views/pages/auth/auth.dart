import 'package:flutter/material.dart';
import 'package:iti_community_flutter/views/pages/auth/login.dart';
import 'package:iti_community_flutter/views/pages/auth/reg.dart';

class AuthLoginAndRegistration extends StatefulWidget {
  @override
  _AuthLoginAndRegistrationState createState() =>
      _AuthLoginAndRegistrationState();
}

class _AuthLoginAndRegistrationState extends State<AuthLoginAndRegistration> {
  bool isToggle = false;
  void togglescreen() {
    setState(() {
      isToggle = !isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isToggle) {
      return Registration(togglescreen: togglescreen);
    } else {
      return Login(togglescreen: togglescreen);
    }
  }
}
