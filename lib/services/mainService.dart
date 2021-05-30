import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class mainService {
  final _collectdata = StreamController();
  var userDetails;
  Future getdata(id) async {
    FirebaseFirestore.instance
        .collection('users-details')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        userDetails = await documentSnapshot.data();
        _collectdata.sink.add(userDetails);
      }
    });
  }

  Stream get stream => _collectdata.stream;
}
