import 'package:cloud_firestore/cloud_firestore.dart';

class GroupService {
  static deletePost(id) async {
    FirebaseFirestore.instance.collection('PostGroup').doc(id).delete();
  }

  static editPost(id, body) async {
    FirebaseFirestore.instance
        .collection('PostGroup')
        .doc(id)
        .update({'Body': body});
  }

  static editComment(id, cid, body) async {
    FirebaseFirestore.instance
        .collection('PostGroup')
        .doc(id)
        .collection('Comments')
        .doc(cid)
        .update({'Body': body});
  }

  static deleteComment(id, cid) async {
    FirebaseFirestore.instance
        .collection('PostGroup')
        .doc(id)
        .collection('Comments')
        .doc(cid)
        .delete();
  }

  static deleteUser(gid, uid) async {
    FirebaseFirestore.instance
        .collection('Groups2')
        .doc(gid)
        .collection('Users')
        .doc(uid)
        .delete();
  }

  static updateUserRole(gid, uid, role) async {
    FirebaseFirestore.instance
        .collection('Groups2')
        .doc(gid)
        .collection('Users')
        .doc(uid)
        .update({'Role': role});
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
