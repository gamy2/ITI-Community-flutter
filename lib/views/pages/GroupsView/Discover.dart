import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iti_community_flutter/services/GroupsService.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/views/pages/GroupsView/singleGroup.dart';
import 'package:iti_community_flutter/views/widgets/Spinner.dart';
import 'package:provider/provider.dart';

class DiscoverGroups extends StatefulWidget {
  @override
  _DiscoverGroupsState createState() => _DiscoverGroupsState();
}

class _DiscoverGroupsState extends State<DiscoverGroups> {
  final Stream<QuerySnapshot> _fb =
      FirebaseFirestore.instance.collection('Groups2').snapshots();
  @override
  Widget build(BuildContext context) {
    var users = [];
    final authServices = Provider.of<AuthServices>(context);
    final userDetails = authServices.storage.getItem('userDetails');

    final userid = authServices.storage.getItem('uid');
    // GroupService.getAllGroups();
    return StreamBuilder<QuerySnapshot>(
      stream: _fb,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Spinner();
        }
        if (!snapshot.hasData) return Spinner();

        return Scaffold(
          body: new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot docs) {
              Stream<QuerySnapshot> us = FirebaseFirestore.instance
                  .collection('Groups2/${docs.id}/Users')
                  .snapshots();
              return StreamBuilder(
                stream: us,
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> user) {
                  if (user.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Spinner());
                  } else if (!user.hasData) {
                    return Center(child: Spinner());
                  } else if (user.data.docs == null) {
                    return Center(child: Spinner());
                  }
                  return Column(
                    children: [
                      for (var i in user.data.docs)
                        if (i.id == userid)
                          //   if ((i.data() as Map)['Role'] == null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: new ListTile(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SingleGroup(
                                      //             docs.id,
                                      //             docs.data(),
                                      //             i.id,
                                      //             (i.data() as Map)))
                                      //             );
                                    },
                                    leading: Image.network(
                                        (docs.data() as Map)['Img']),
                                    title: InkWell(
                                      child: new Text(
                                          (docs.data() as Map)['Name']),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => GroupService.addUser(
                                      docs.id, userid, userDetails),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.playlist_add_outlined,
                                      color: Colors.green[200],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                    ],
                  );
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
