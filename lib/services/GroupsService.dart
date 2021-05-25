import 'package:cloud_firestore/cloud_firestore.dart';

class GroupService {
  static deletePost() {
    print('test');
  }

  // static getAllGroups() async {
  //   Stream<QuerySnapshot> _fb;
  //   Stream<QuerySnapshot> _fbToReturn;
  //   await FirebaseFirestore.instance
  //       .collection('Groups2')
  //       .get()
  //       .then((value) => {
  //             for (var i in value.docs)
  //               {
  //                 _fb = FirebaseFirestore.instance
  //                     .collection('Groups2')
  //                     .doc(i.id)
  //                     .collection('Users')
  //                     .where('Role', isGreaterThan: 0)
  //                     .snapshots()
  //                     .forEach((element) {
  //                   for (var u in element.docs) {
  //                     print(u.id);
  //                     print(i.id);
  //                   }
  //                 }) as Stream<QuerySnapshot>
  //               }
  //           });
  //   return _fbToReturn;
  // }
}
