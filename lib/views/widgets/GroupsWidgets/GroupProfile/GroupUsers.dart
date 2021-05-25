import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/services/GroupsService.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/views/pages/profile/profile.dart';
import 'package:iti_community_flutter/views/widgets/Spinner.dart';

class GroupUsers extends StatefulWidget {
  final String id;
  GroupUsers(this.id);

  @override
  _GroupUsersState createState() => _GroupUsersState();
}

class _GroupUsersState extends State<GroupUsers> {
  @override
  Widget build(BuildContext context) {
    var uid = AuthServices.userID;
    var admins = [];

    // void handleClick(String value, id) {
    //   switch (value) {
    //     case 'Admin':
    //       break;
    //     case 'Member':
    //       break;
    //     case 'Subscriber':
    //       break;
    //     case 'Delete':
    //       GroupService.deleteUser(
    //         widget.id,
    //       );
    //       break;
    //   }
    // }

    final Stream<QuerySnapshot> _fb = FirebaseFirestore.instance
        .collection('Groups2')
        .doc(widget.id)
        .collection('Users')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _fb,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Spinner();
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Members'),
            backgroundColor: HexColor("801818"),
          ),
          body: new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot docs) {
              if (docs.data()['Role'] == 1) admins.add(docs.id);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: new ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile(docs.id)));
                        },
                        leading: Image.network(
                          docs.data()['avatar'],
                          width: 60,
                        ),
                        title: InkWell(
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Text(docs.data()['firstName']),
                              SizedBox(width: 3),
                              Text(docs.data()['lastName']),
                              if (docs.data()['Role'] == 2)
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Badge(
                                      toAnimate: false,
                                      shape: BadgeShape.square,
                                      badgeColor: Colors.blue[300],
                                      borderRadius: BorderRadius.circular(8),
                                      badgeContent: Text('Member',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              if (docs.data()['Role'] == 1)
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Badge(
                                      toAnimate: false,
                                      shape: BadgeShape.square,
                                      badgeColor: Colors.lightGreen[300],
                                      borderRadius: BorderRadius.circular(8),
                                      badgeContent: Text('Admin',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              if (docs.data()['Role'] == 0)
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Badge(
                                      toAnimate: false,
                                      shape: BadgeShape.square,
                                      badgeColor: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(8),
                                      badgeContent: Text('Subscriber',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (admins.contains(uid))
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          switch (value) {
                            case 'Admin':
                              GroupService.updateUserRole(
                                  widget.id, docs.id, 1);
                              break;
                            case 'Member':
                              GroupService.updateUserRole(
                                  widget.id, docs.id, 2);
                              break;
                            case 'Subscriber':
                              GroupService.updateUserRole(
                                  widget.id, docs.id, 0);
                              break;
                            case 'Delete':
                              GroupService.deleteUser(widget.id, docs.id);
                              break;
                          }
                        },
                        //                     PopupMenuButton<String>(
                        // onSelected: (String result) { setState(() { _selection = result; }); },
                        // itemBuilder: (BuildContext context) {
                        //   const PopupMenuItem<String>(
                        //     value: GroupService.deleteUser(widget.id, docs.id),
                        //     child: Text('Working a lot harder'),
                        //   ),
                        //   const PopupMenuItem<WhyFarther>(
                        //     value: WhyFarther.smarter,
                        //     child: Text('Being a lot smarter'),
                        //   ),
                        //   const PopupMenuItem<WhyFarther>(
                        //     value: WhyFarther.selfStarter,
                        //     child: Text('Being a self-starter'),
                        //   ),
                        //   const PopupMenuItem<WhyFarther>(
                        //     value: WhyFarther.tradingCharter,
                        //     child: Text('Placed in charge of trading charter'),
                        //   );
                        //           },)
                        itemBuilder: (BuildContext context) {
                          return {'Admin', 'Member', 'Subscriber', 'Delete'}
                              .map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}