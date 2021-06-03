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

  Future<List> getBranches() async {
    List Branches = [];
    try {
      FirebaseFirestore.instance
          .collection('Branches')
          .get()
          .then((QuerySnapshot res) {
        res.docs.forEach((doc) {
          Branches.add(doc);
        });
        print(Branches.length);
      });
    } catch (e) {
      print(e);
    }
    return Branches;
  }

  Future<List> getTracks() async {
    List Tracks = [];
    try {
      FirebaseFirestore.instance
          .collection('Tracks')
          .get()
          .then((QuerySnapshot res) {
        res.docs.forEach((doc) {
          Tracks.add(doc);
        });
        print(Tracks.length);
      });
    } catch (e) {
      print(e);
    }
    return Tracks;
  }
}
