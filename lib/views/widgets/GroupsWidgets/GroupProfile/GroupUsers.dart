import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/app_localizations.dart';
import 'package:iti_community_flutter/services/GroupsService.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/views/pages/profile/profile.dart';
import 'package:iti_community_flutter/views/widgets/Spinner.dart';
import 'package:provider/provider.dart';

class GroupUsers extends StatefulWidget {
  final String id;
  GroupUsers(this.id);

  @override
  _GroupUsersState createState() => _GroupUsersState();
}

class _GroupUsersState extends State<GroupUsers> {
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final uid = authServices.storage.getItem('uid');
    var admins = [];

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
            title: Text(AppLocalizations.of(context).translate('Members')),
            backgroundColor: HexColor("801818"),
          ),
          body: new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot docs) {
              if ((docs.data() as Map)['Role'] == 1) admins.add(docs.id);
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
                          (docs.data() as Map)['avatar'],
                          width: 60,
                        ),
                        title: InkWell(
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Text((docs.data() as Map)['firstName']),
                              SizedBox(width: 3),
                              Text((docs.data() as Map)['lastName']),
                              if ((docs.data() as Map)['Role'] == 2)
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
                                      badgeContent: Text(
                                          AppLocalizations.of(context)
                                              .translate('Member'),
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              if ((docs.data() as Map)['Role'] == 1)
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
                                      badgeContent: Text(
                                          AppLocalizations.of(context)
                                              .translate('Admin'),
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              if ((docs.data() as Map)['Role'] == 0)
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
                                      badgeContent: Text(
                                          AppLocalizations.of(context)
                                              .translate('Subscriber'),
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
                        itemBuilder: (BuildContext context) {
                          return {'Admin', 'Member', 'Subscriber', 'Delete'}
                              .map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(AppLocalizations.of(context)
                                  .translate(choice)),
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
