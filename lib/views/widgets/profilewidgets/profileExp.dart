import 'package:flutter/material.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';

class profileExp extends StatefulWidget {
  profileExp(this.experiences, this.uid);
  final experiences;
  final uid;
  @override
  _profileExpState createState() => _profileExpState();
}

class _profileExpState extends State<profileExp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Experiences",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
                textAlign: TextAlign.left,
              ),
            ),
          ]),
          widget.experiences.length > 0 ? Text("no data") : null,
          Row(children: <Widget>[
            Expanded(child: Divider()),
            Expanded(child: Divider()),
          ]),
          widget.uid == AuthServices.userID
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: InkWell(
                          child: Text(
                            "+",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                  ],
                )
              : null
        ],
      ),
    );
  }
}
