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
                      height: 50,
                    ),
                    Text('Hello From Other Side'),
                    // Form(
                    //   child: (TextFormField(
                    //     decoration: InputDecoration(
                    //         hintText: "Write Post",
                    //         prefixIcon: Icon(Icons.edit_rounded)),
                    //   )),
                    // ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        right: -40.0,
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
                                      Form(
                                        // key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                child: Text("Submitß"),
                                                onTap: () {
                                                  // if (_formKey.currentState
                                                  //     .validate()) {
                                                  //   _formKey.currentState.save();
                                                  // }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  width: 1.0, color: Color(0xFF000000)),
                              bottom: BorderSide(
                                  width: 1.0, color: Color(0xFF000000)),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
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
