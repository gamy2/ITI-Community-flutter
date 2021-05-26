import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iti_community_flutter/services/GroupsService.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/views/pages/GroupsView/singleGroup.dart';
import 'package:iti_community_flutter/views/widgets/Spinner.dart';
import 'package:provider/provider.dart';

class RequestedGroups extends StatefulWidget {
  @override
  _RequestedGroupsState createState() => _RequestedGroupsState();
}

class _RequestedGroupsState extends State<RequestedGroups> {
  final Stream<QuerySnapshot> _fb =
      FirebaseFirestore.instance.collection('Groups2').snapshots();
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
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
                  if (user.connectionState == ConnectionState.waiting) {
                    return Center(child: Spinner());
                  }
                  if (!user.hasData) return Center(child: Spinner());

                  if (user.data.docs == null) return Center(child: Spinner());

                  return Column(
                    children: [
                      for (var i in user.data.docs)
                        if (i.id == userid && (i.data() as Map)['Role'] == 0)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: new ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SingleGroup(
                                                  docs.id,
                                                  docs.data(),
                                                  i.id,
                                                  (i.data() as Map))));
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
                                  onTap: () =>
                                      GroupService.deleteUser(docs.id, userid),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.remove_circle_outline,
                                      color: Colors.red[300],
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
