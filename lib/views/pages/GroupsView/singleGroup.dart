import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iti_community_flutter/app_localizations.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/views/widgets/GroupsWidgets/GroupProfile/GroupCard.dart';
import 'package:iti_community_flutter/views/widgets/GroupsWidgets/GroupProfile/GroupUsers.dart';
import 'package:iti_community_flutter/views/widgets/Spinner.dart';
import 'package:provider/provider.dart';

class SingleGroup extends StatefulWidget {
  final String id;
  final data;
  final user;
  final uRole;
  SingleGroup(this.id, this.data, this.uRole, this.user);
  @override
  _SingleGroupState createState() => _SingleGroupState();
}

class _SingleGroupState extends State<SingleGroup> {
  String postBody;
  final _formKey = GlobalKey<FormState>();
  final controlPostBody = TextEditingController();

  var last;
  var len;
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final userDetails = authServices.storage.getItem('userDetails');
    final uid = authServices.storage.getItem('uid');

    CollectionReference post =
        FirebaseFirestore.instance.collection('PostGroup');
    Future writePost(String body) async {
      return await post.add({
        'Body': body,
        'GroupId': widget.id,
        'Likes': [],
        'PostedDate': DateTime.now(),
        'postImg': [],
        'Auther': {
          'id': uid,
          'firstName': userDetails['firstName'],
          'lastName': userDetails['lastName'],
          'jobTitle': userDetails['jobTitle'],
          'avatar': userDetails['avatar'],
        }
      });
    }

    Stream<QuerySnapshot> _fb2 = FirebaseFirestore.instance
        .collection('PostGroup')
        .orderBy('PostedDate', descending: true)
        .where("GroupId", isEqualTo: widget.id)
        .snapshots();

    // void showMore() {
    //   _fb2 = FirebaseFirestore.instance
    //       .collection('PostGroup')
    //       .where("GroupId", isEqualTo: widget.id)
    //       .orderBy('PostedDate', descending: true)
    //       .startAfter([last]).snapshots();
    //   print(_fb2);
    //   print(last);
    // }

    return StreamBuilder<QuerySnapshot>(
        stream: _fb2,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Spinner();
          }
          // last = snapshot.data.docs[snapshot.data.docs.length - 1];
          // last = snapshot.data.docs.map((e) => e.id);
          void showMore() {
            _fb2 = FirebaseFirestore.instance
                .collection('PostGroup')
                .where("GroupId", isEqualTo: widget.id)
                // .limit(1)
                .orderBy('PostedDate', descending: true)
                .startAfter([last]).snapshots();
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(widget.data['Name']),
              backgroundColor: HexColor("801818"),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GroupUsers(widget.id))),
                      child: Icon(Icons.supervised_user_circle_outlined)),
                )
              ],
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
                      padding:
                          const EdgeInsets.only(top: 12, right: 12, left: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
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
                    if (widget.uRole == uid && widget.user['Role'] > 0)
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
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Container(
                                                      height: 200,
                                                      child: TextFormField(
                                                        maxLines: null,
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        decoration: InputDecoration.collapsed(
                                                            hintText: AppLocalizations
                                                                    .of(context)
                                                                .translate(
                                                                    'whatDoYouThinkingAbout?...!')),
                                                        // ignore: missing_return
                                                        validator: (value) {
                                                          value.isEmpty;
                                                          // ignore: unnecessary_statements
                                                          value.length > 3;
                                                        },
                                                        controller:
                                                            controlPostBody,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        'Post'),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          final String body =
                                                              controlPostBody
                                                                  .text;
                                                          if (body != null ||
                                                              body.length > 3) {
                                                            writePost(body);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
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
                                top: BorderSide(
                                    width: 1.0, color: Colors.black54),
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.black54),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.edit),
                                  Text(AppLocalizations.of(context)
                                      .translate('writePostHere'))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (snapshot.data.docs.isEmpty)
                      Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('noPostsYet'),
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400]),
                          ),
                        ],
                      ),
                    if (widget.uRole == uid && widget.user['Role'] == 0)
                      Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('NotReconized'),
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400],
                                backgroundColor: Colors.lightBlue[50]),
                          ),
                        ],
                      )),
                    if (widget.uRole == uid && widget.user['Role'] > 0)
                      Column(
                          children: snapshot.data.docs
                              .map(
                                (e) => GroupCard(
                                    e.id, e.data(), widget.uRole, widget.user),
                              )
                              .toList()),

                    // InkWell(
                    //     onTap: () {
                    //       showMore();
                    //     },
                    //     child: Text('Show More'))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
