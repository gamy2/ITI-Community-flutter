import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iti_community_flutter/views/pages/HomePage.dart';
import 'package:iti_community_flutter/views/pages/auth/auth.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      return StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return HomePage();
          });
    } else {
      return AuthLoginAndRegistration();
    }
  }
}
