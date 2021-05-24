import 'package:flutter/material.dart';

class profileAbout extends StatefulWidget {
  final String about;

  profileAbout(this.about);

  @override
  _profileAboutState createState() => _profileAboutState();
}

class _profileAboutState extends State<profileAbout> {
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
          SizedBox(
            height: 20,
          ),
          Text(widget.about)
        ],
      ),
    );
  }
}
