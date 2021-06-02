import 'package:cloud_firestore/cloud_firestore.dart';

class Getdata {
  Future<List<String>> getFriendList(id) async {
    List<String> friendList = [];
    try {
      FirebaseFirestore.instance
          .collection('users-details')
          .doc(id)
          .collection('friendList')
          .get()
          .then((QuerySnapshot res) {
        res.docs.forEach((doc) {
          friendList.add(doc.id);
        });
        print(friendList.length);
      });
    } catch (e) {
      print(e);
    }
    return friendList;
  }

  Future<List<String>> getMyRequests(id) async {
    List<String> friendList = [];
    try {
      FirebaseFirestore.instance
          .collection('users-details')
          .doc(id)
          .collection('friendList')
          .get()
          .then((QuerySnapshot res) {
        res.docs.forEach((doc) {
          friendList.add(doc.id);
        });
        print(friendList.length);
      });
    } catch (e) {
      print(e);
    }
    return friendList;
  }

  Future<List<String>> getRequest(id) async {
    List<String> friendList = [];
    try {
      FirebaseFirestore.instance
          .collection('users-details')
          .doc(id)
          .collection('friendList')
          .get()
          .then((QuerySnapshot res) {
        res.docs.forEach((doc) {
          friendList.add(doc.id);
        });
        print(friendList.length);
      });
    } catch (e) {
      print(e);
    }
    return friendList;
  }
}
