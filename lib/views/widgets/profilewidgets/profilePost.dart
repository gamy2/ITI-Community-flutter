import 'package:flutter/material.dart';

class profilePost extends StatefulWidget {
  profilePost(this.id, this.data, this.uid, this.user);
  final id;
  final data;
  final uid;
  final user;
  @override
  _profilePostState createState() => _profilePostState();
}

class _profilePostState extends State<profilePost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(widget.data["Auther"]['avatar']),
                  radius: 30.0,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data["Auther"]['firstName'] +
                        ' ' +
                        widget.data["Auther"]['lastName'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.data["Auther"]['jobTitle'])
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.data["Body"]),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: widget.data['postImg']
                .map<Widget>((imgUrl) => SizedBox(
                      height: 100,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: NetworkImage(imgUrl),
                          height: 80,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
