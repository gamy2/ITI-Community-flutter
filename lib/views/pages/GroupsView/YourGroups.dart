import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iti_community_flutter/views/pages/GroupsView/singleGroup.dart';

class YourGroups extends StatefulWidget {
  @override
  _YourGroupsState createState() => _YourGroupsState();
}

class _YourGroupsState extends State<YourGroups> {
  @override
  final Stream<QuerySnapshot> _fb =
      FirebaseFirestore.instance.collection('Groups2').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fb,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return Scaffold(
          body: new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot docs) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: new ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SingleGroup(docs.id, docs.data())));
                  },
                  leading: Image.network(docs.data()['Img']),
                  title: InkWell(
                    child: new Text(docs.data()['Name']),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
