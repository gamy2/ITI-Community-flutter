import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iti_community_flutter/services/GroupsService.dart';
import 'package:iti_community_flutter/views/pages/GroupsView/singleGroup.dart';
import 'package:iti_community_flutter/views/widgets/Spinner.dart';

class YourGroups extends StatefulWidget {
  @override
  _YourGroupsState createState() => _YourGroupsState();
}

class _YourGroupsState extends State<YourGroups> {
  var allGroups;
  @override
  final Stream<QuerySnapshot> _fb =
      FirebaseFirestore.instance.collection('Groups2').snapshots();
  @override
  Widget build(BuildContext context) {
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

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:iti_community_flutter/services/auth/Authentication.dart';
// import 'package:iti_community_flutter/views/pages/GroupsView/singleGroup.dart';
// import 'package:iti_community_flutter/views/widgets/Spinner.dart';

// class YourGroups extends StatefulWidget {
//   @override
//   _YourGroupsState createState() => _YourGroupsState();
// }

// class _YourGroupsState extends State<YourGroups> {
//   @override
//   final Future<QuerySnapshot> _fb = FirebaseFirestore.instance
//       .collection('Groups2')
//       .get()
//       .then((DocumentSnapshot docs) => docs.data()));
//   @override
//   Widget build(BuildContext context) {
//     var uid = AuthServices.userID;
//     var member = [];
//     var myGroups;
//     final groups = [];
//     print(_fb);
//     return StreamBuilder<QuerySnapshot>(
//       // stream: _fb,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Spinner();
//         }
//         // for (var i in snapshot.data.docs) {
//         //   groups.add(i);
//         //   // snapshot.data.docs.forEach((element) async {
//         //   FirebaseFirestore.instance
//         //       .collection('Groups2')
//         //       .doc(i.id)
//         //       .collection('Users')
//         //       .where('Role', isGreaterThan: 0)
//         //       .get()
//         //       .then((value) => value.docs.forEach((element) {
//         //             member.add(element.id);
//         //             // print(member);
//         //           }));
//         //   // });
//         // }
//         // for (var i in snapshot.data.docs) {
//         //   snapshot.data.docs.forEach((element) async {
//         //     FirebaseFirestore.instance
//         //         .collection('Groups2')
//         //         .doc(i.id)
//         //         .collection('Users')
//         //         // .doc(uid)
//         //         .get()
//         //         .then((value) {
//         //       for (var z in value.docs) {
//         //         if (z.data()['Role'] > 0) {
//         //           // groups.add(i);
//         //           // // print(groups);
//         //           groups.add(i);
//         //           for (var g in groups) {
//         //             print(g.id);
//         //           }
//         //         }
//         //       }
//         //     });
//         //   });
//         // }
//         // for (var i in snapshot.data.docs) {
//         //   snapshot.data.docs.forEach((element) {
//         //     FirebaseFirestore.instance
//         //         .collection('Groups2')
//         //         .doc(i.id)
//         //         .collection('Users')
//         //         .doc(uid)
//         //         .get()
//         //         .then((value) {
//         //       if (value.data()['Role'] > 0) {
//         //         // groups.add(i);
//         //         // // print(groups);
//         //         setState(() {
//         //           groups.add({'id :${i.id}', 'data: ${i.data()}'});
//         //         });
//         //         myGroups = [...groups];
//         //       }
//         //     });
//         //   });
//         // }
//         // print(myGroups);
//         return Scaffold(
//           body: new ListView(
//             // children: groups.map((docs) {
//             //   return Padding(
//             //     padding: const EdgeInsets.all(8.0),
//             //     child: new ListTile(
//             //       onTap: () {
//             //         Navigator.push(
//             //             context,
//             //             MaterialPageRoute(
//             //                 builder: (context) =>
//             //                     SingleGroup(docs.id, docs.data())));
//             //       },
//             //       leading: Image.network(docs.data()['Img']),
//             //       title: InkWell(
//             //         child: new Text(docs.data()['Name']),
//             //       ),
//             //     ),
//             //   );
//             // }).toList(),
//             children: groups
//                 .map((docs) => Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: new ListTile(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       SingleGroup(docs.id, docs.data())));
//                         },
//                         leading: Image.network(docs.data()['Img']),
//                         title: InkWell(
//                           child: new Text(docs.data()['Name']),
//                         ),
//                       ),
//                     ))
//                 .toList(),
//           ),
//         );
//       },
//     );
//   }
// }
