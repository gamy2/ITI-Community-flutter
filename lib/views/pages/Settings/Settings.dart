import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/app_localizations.dart';
import 'package:iti_community_flutter/main.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/services/getData.dart';
import 'package:provider/provider.dart';

class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  List<String> friendList;
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
    final authServices = Provider.of<AuthServices>(context);
    final userDetails = authServices.storage.getItem("userDetails");

    // final ahmed = ["a", 'h', 'm', 'e', 'd'];
    // var a = 'z';
    // if (ahmed.contains(a)) {
    //   print('dd');
    // } else {
    //   print('blela');
    // }
    // authServices.getFriendList(firebaseAuth.currentUser.uid);
    // var alpha = authServices.storage.getItem("alpha");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("801818"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: InkWell(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800]),
                  ),
                  onTap: () {
                    authServices.logout();
                    // print(friendList);
                    // var s = AuthServices.store.getItem('uid');
                    // print(s);
                    // var s = AuthServices.userID;
                    // print(s);
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Card(
            //     child: InkWell(
            //       child: Text(
            //         'get data',
            //         style: TextStyle(
            //             fontSize: 28,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.blue[800]),
            //       ),
            //       onTap: () {
            //         // authServices.logout();
            //         // print(belal.userDetails);
            //         print(userDetails);
            //         // var s = AuthServices.store.getItem('uid');
            //         // print(s);
            //         // var s = AuthServices.userID;
            //         // print(s);
            //       },
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
