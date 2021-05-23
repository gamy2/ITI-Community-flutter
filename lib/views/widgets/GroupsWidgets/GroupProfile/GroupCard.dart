import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/views/widgets/GroupsWidgets/GroupProfile/Comments.dart';
import 'package:iti_community_flutter/views/widgets/GroupsWidgets/GroupProfile/SinglePost.dart';
import 'package:like_button/like_button.dart';

class GroupCard extends StatefulWidget {
  final String id;
  final data;
  GroupCard(this.id, this.data);
  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> likes = <dynamic>[];
    var userid = AuthServices.userID;
    var a = widget.data['Likes'].contains(userid);

    final Stream<QuerySnapshot> _fb2 = FirebaseFirestore.instance
        .collection('PostGroup')
        .doc(widget.id)
        .collection('Comments')
        .orderBy('CommentDate', descending: true)
        .limit(4)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _fb2,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Spinner();
          // }

          Future<bool> giveLike(bool isLiked) async {
            final Future<List> _fb2 = FirebaseFirestore.instance
                .collection('PostGroup')
                .doc(widget.id)
                .get()
                // ignore: missing_return
                .then((value) async {
              List.from(value.data()['Likes']).forEach((element) {
                likes.add(element);
              });
              if (a == true) {
                var rem = likes.indexOf(userid);
                likes.removeAt(rem);
                FirebaseFirestore.instance
                    .collection('PostGroup')
                    .doc(widget.id)
                    .update({'Likes': likes});
              } else {
                likes.add(userid);
                FirebaseFirestore.instance
                    .collection('PostGroup')
                    .doc(widget.id)
                    .update({'Likes': likes});
              }
            });
            return !isLiked;
          }

          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: SizedBox(
                          height: 60,
                          width: 60,
                          child: Image(
                            image:
                                NetworkImage(widget.data['Auther']['avatar']),
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(widget.data['Auther']['firstName']),
                            SizedBox(
                              width: 3,
                            ),
                            Text(widget.data['Auther']['lastName']),
                          ],
                        ),
                        subtitle: Text(
                          widget.data['Auther']['jobTitle'],
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          widget.data['Body'],
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
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
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          LikeButton(
                            onTap: giveLike,
                            size: 30,
                            circleColor: CircleColor(
                                start: Color(0xff00ddff),
                                end: Color(0xff0099cc)),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Color(0xff33b5e5),
                              dotSecondaryColor: Color(0xff0099cc),
                            ),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                a ? Icons.favorite : Icons.favorite_border,
                                color: a ? Colors.grey : Colors.grey,
                                size: 30,
                              );
                            },
                            likeCount: widget.data['Likes'].length,
                            countBuilder:
                                (int count, bool isLiked, String text) {
                              var color =
                                  a ? Colors.deepPurpleAccent : Colors.grey;
                              Widget result;
                              if (count == 0) {
                                result = Text(
                                  "Like",
                                  style: TextStyle(color: color),
                                );
                              } else
                                result = Text(
                                  text,
                                  style: TextStyle(color: color),
                                );
                              return result;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SinglePost(widget.id, widget.data))),
                              child: Row(
                                children: [
                                  Icon(Icons.mode_comment_outlined),
                                  Text(
                                    '  Comment',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black),
                      Column(
                          children: snapshot.data.docs
                              .map(
                                (e) => Comments(e.id, e.data()),
                              )
                              .toList()),
                      if (snapshot.data.docs.length > 3)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SinglePost(widget.id, widget.data))),
                            child: Text(
                              'Load More Comments',
                              style: TextStyle(color: Colors.blue[300]),
                            ),
                          ),
                        ),
                      if (snapshot.data.docs.length == 0)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SinglePost(widget.id, widget.data))),
                            child: Text(
                              'Be First One Comment',
                              style: TextStyle(color: Colors.blue[300]),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
