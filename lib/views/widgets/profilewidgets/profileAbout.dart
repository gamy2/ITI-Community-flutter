import 'package:flutter/material.dart';

class profileAbout extends StatefulWidget {
  final String about;

  profileAbout(this.about);

  @override
  _profileAboutState createState() => _profileAboutState();
}

class _profileAboutState extends State<profileAbout> {
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "about",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            ),
          ),

          widget.about.length == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 1,
                    ),
                    Column(children: [
                      Text("SORRY , This Account Has No About"),
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
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(widget.about),
                )

        ],
      ),
    );
  }
}
