import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iti_community_flutter/views/widgets/GroupsWidgets/GroupProfile/GroupCard.dart';
import 'package:iti_community_flutter/views/widgets/Spinner.dart';

class SingleGroup extends StatefulWidget {
  final String id;
  final data;
  SingleGroup(this.id, this.data);
  @override
  _SingleGroupState createState() => _SingleGroupState();
}

class _SingleGroupState extends State<SingleGroup> {
  String postBody;
  final _formKey = GlobalKey<FormState>();
  CollectionReference post = FirebaseFirestore.instance.collection('PostGroup');
  Future writePost() async {
    return await post.add({
      'Body': postBody,
      'GroupId': widget.id,
      'Likes': [],
      'PostedDate': DateTime.now(),
      'postImg': [],
      'Auther': {
        'id': '7Kxxu7T1AZYTDlbrzOH2Cun5uJm2',
        'firstName': 'Mohamed',
        'lastName': 'Farghal',
        'jobTitle': 'MEAN Stack Developer',
        'avatar':
            'https://firebasestorage.googleapis.com/v0/b/iti-community.appspot.com/o/UsersProfileImages%2Ffiver_g6.y02txtt?alt=media&token=92c5c725-c4d1-49da-bc9f-949010cb5586'
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _fb2 = FirebaseFirestore.instance
        .collection('PostGroup')
        .where("GroupId", isEqualTo: widget.id)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _fb2,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Spinner();
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.data['Name']),
              backgroundColor: HexColor("801818"),
            ),
            backgroundColor: Colors.brown[50],
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/1200x400.jpg"),
                                  fit: BoxFit.cover)),
                          child: Container(
                            width: double.infinity,
                            height: 130,
                            child: Container(
                              alignment: Alignment(-0.9, 10),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(widget.data['Img']),
                                radius: 60.0,
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 280,
                          ),
                          Icon(
                            Icons.notifications,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            widget.data['Name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.group),
                          Text('  Listed Group'),
                        ],
                      ),
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  insetPadding: EdgeInsets.zero,
                                  content: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        // right: -40.0,
                                        top: -40.0,
                                        child: InkResponse(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: CircleAvatar(
                                            child: Icon(Icons.close),
                                            backgroundColor: Colors.red,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 280,
                                        child: SingleChildScrollView(
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height: 200,
                                                    child: TextFormField(
                                                      maxLines: null,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      decoration: InputDecoration
                                                          .collapsed(
                                                              hintText:
                                                                  'What Do You Thinking About?!..'),
                                                      validator: (value) {
                                                        value.isEmpty;
                                                        value.length > 5;
                                                      },
                                                      onChanged:
                                                          (String value) {
                                                        setState(() {
                                                          postBody = value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Material(
                                                    color: Colors.blue[400],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                    child: InkWell(
                                                      highlightColor:
                                                          Colors.blue[100],
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(Icons.edit),
                                                            Text(
                                                              "Post",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        if (_formKey
                                                            .currentState
                                                            .validate()) {
                                                          _formKey.currentState
                                                              .save();
                                                          writePost();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top:
                                  BorderSide(width: 1.0, color: Colors.black54),
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black54),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit),
                                Text('Write Post Here')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                        children: snapshot.data.docs
                            .map(
                              (e) => GroupCard(e.id, e.data()),
                            )
                            .toList())
                  ],
                ),
              ),
            ),
          );
        });
  }
}
