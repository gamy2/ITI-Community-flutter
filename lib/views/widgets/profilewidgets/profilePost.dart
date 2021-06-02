import 'package:flutter/material.dart';
import 'package:iti_community_flutter/views/pages/home/profileComments.dart';
import 'package:iti_community_flutter/views/pages/profile/profile.dart';

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
          (widget.data["Auther"]['avatar'] != null
              ? InkWell(
                  child: Row(
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(widget.data["Auther"]['jobTitle'])
                        ],
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(
                                (widget.data['Auther']['id'] != null
                                    ? widget.data['Auther']['id']
                                    : ''))));
                  },
                )
              : Text(' ')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.data["Body"]),
          ),
          widget.data['postImg'] != ''
              ? Wrap(
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
                      .toList())
              : Text(' '),
          profileComments(widget.id, widget.uid, widget.user),
        ],
      ),
    );
  }
}
