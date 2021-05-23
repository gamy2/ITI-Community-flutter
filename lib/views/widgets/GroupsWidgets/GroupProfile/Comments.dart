import 'package:flutter/material.dart';
import 'package:iti_community_flutter/views/pages/profile/profile.dart';

class Comments extends StatefulWidget {
  final String id;
  final data;
  Comments(this.id, this.data);
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        color: Colors.grey[350],
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[350],
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, spreadRadius: 2, blurRadius: 100),
            ],
          ),
          child: Column(
            children: [
              ListTile(
                minVerticalPadding: 0,
                leading: Container(
                  height: 100,
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.data['User']['avatar']),
                    radius: 40,
                  ),
                ),
                title: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Profile(widget.data['User']['id'])));
                  },
                  child: Row(
                    children: [
                      Text(
                        widget.data['User']['firstName'],
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        widget.data['User']['lastName'],
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
                subtitle: Text(
                  widget.data['User']['jobTitle'],
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6), fontSize: 12),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data['Body'],
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
