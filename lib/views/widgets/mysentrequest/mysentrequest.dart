import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/views/pages/profile/profile.dart';
import 'package:provider/provider.dart';

class mySentRequest extends StatefulWidget {
  mySentRequest(this.data);
  final data;
  @override
  _mySentRequestState createState() => _mySentRequestState();
}

class _mySentRequestState extends State<mySentRequest> {
  bool isLoaded = false;
  getdata() {
    Timer.periodic(new Duration(seconds: 1), (timer) {
      isLoaded = true;
      if (this.mounted) setState(() {});
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);

    // authServices.getDataById(widget.uid);
    // var userDetails = authServices.storage.getItem("clickedDetails");
    if (!isLoaded) {
      return new Container(
          color: Colors.white,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(HexColor('801818')),
                  ),
                  height: 40.0,
                  width: 40.0,
                )
              ],
            ),
          ));
    } else {
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.data['avatar']),
                          radius: 30.0,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (widget.data['firstName']),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(widget.data['jobTitle'])
                        ],
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(widget.data['id'])));
                  },
                ),
                SizedBox(
                  width: 1,
                ),
                Row(),
              ],
            )
          ],
        ),
      );
    }
  }
}
