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

  static addUser(gid, uid, data) {
    FirebaseFirestore.instance
        .collection('Groups2')
        .doc(gid)
        .collection('Users')
        .doc(uid)
        .set({
      'Role': 0,
      'firstName': data['firstName'],
      'lastName': data['lastName'],
      'jobTitle': data['jobTitle'],
      'avatar': data['avatar'],
    });
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
}
