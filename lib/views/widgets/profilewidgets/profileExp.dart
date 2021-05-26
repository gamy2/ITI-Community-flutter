import 'package:flutter/material.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';

class profileExp extends StatefulWidget {
  profileExp(this.experiences, this.uid);
  final List experiences;
  final uid;
  @override
  _profileExpState createState() => _profileExpState();
}

class _profileExpState extends State<profileExp> {
  var img =
      "https://firebasestorage.googleapis.com/v0/b/iti-community.appspot.com/o/112-1120219_goal-clipart-know-yourself-myself-clipart.png?alt=media&token=d29ee586-8544-4ee5-a531-1c5a7f96285a";
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
          widget.experiences.length == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 1,
                    ),
                    Column(children: [
                      Text("SORRY , This Account Has No Experiences"),
                      Container(
                        child: Image.network(img),
                        width: 300,
                      )
                    ]),
                    SizedBox(
                      width: 1,
                    ),
                  ],
                )
              : Column(
                  children: widget.experiences
                      .map((e) => Text(e.toString()))
                      .toList(),
                ),
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
