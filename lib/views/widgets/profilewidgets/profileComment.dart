import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class profileComment extends StatefulWidget {
  profileComment(this.id, this.data, this.uid, this.user);
  final id;
  final data;
  final uid;
  final user;
  @override
  _profileCommentState createState() => _profileCommentState();
}

class _profileCommentState extends State<profileComment> {
  @override
  Widget build(BuildContext context) {
    return (widget.data["User"]['avatar'] != null
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.data["User"]['avatar']),
                        radius: 30.0,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data["User"]['firstName'] +
                              ' ' +
                              widget.data["User"]['lastName'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(widget.data["User"]['jobTitle'])
                      ],
                    )
                  ],
                ),
                Text(widget.data['Body'])
              ],
            ),
          )
        : Text(' '));
  }
}
