import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/services/getData.dart';
import 'package:iti_community_flutter/views/pages/home/appHome.dart';
import 'package:provider/provider.dart';

class InzHome extends StatefulWidget {
  @override
  _InzHomeState createState() => _InzHomeState();
}

class _InzHomeState extends State<InzHome> {
  List<String> friendList;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  getData() async {
    friendList = await Getdata().getFriendList(firebaseAuth.currentUser.uid);
    // friendList.forEach((element) {});
    if (this.mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthServices>(context);

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return Home(firebaseAuth.currentUser.uid, friendList);
  }
}
