import 'package:flutter/material.dart';

class profileExp extends StatefulWidget {
  profileExp(this.experiences);
  final experiences;
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Experiences",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
