import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class AuthServices with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // static final LocalStorage store = new LocalStorage('ITI');
  static var userID;

  var userDetails;
  final _collectdata = StreamController();

  final LocalStorage storage = new LocalStorage('iiTi');
  Future Login(String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      storage.setItem("uid", authResult.user.uid);
      FirebaseFirestore.instance
          .collection('users-details')
          .doc(authResult.user.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          await storage.setItem('userDetails', documentSnapshot.data());
          userDetails = documentSnapshot.data();
          _collectdata.sink.add(userDetails);
          User user = authResult.user;
          userID = user.uid;

          // store.setItem('uid', user.uid);

          setLoading(false);
          return user;
        } else {
          print('Document does not exist on the database');
        }
      });
    } on SocketException {
      setLoading(false);
      setErrorMessage("No Internet!");
    } catch (e) {
      setLoading(false);
      setErrorMessage(e.message);
    }
  }

  Future logout() async {
    await firebaseAuth.signOut();
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setErrorMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future getDataById(id) async {
    // print(id);
    // await storage.deleteItem('clickedDetails');
    FirebaseFirestore.instance
        .collection('users-details')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        // await storage.setItem('clickedDetails', "");
        await storage.setItem('clickedDetails', documentSnapshot.data());
        return documentSnapshot.data();
      } else {
        print('2');
      }
    });
  }

  Future getUserDetails(id) async {
    // print(id);
    // await storage.deleteItem('clickedDetails');
    FirebaseFirestore.instance
        .collection('users-details')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        // await storage.setItem('clickedDetails', "");
        await storage.setItem('uDetails', documentSnapshot.data());
      } else {
        print('2');
      }
    });
  }

  Future getUserPostes(id) async {
    // print(id);
    // await storage.deleteItem('clickedDetails');
    FirebaseFirestore.instance
        .collection('users-details')
        .doc(id)
        .collection('MyHomePosts')
        .snapshots();
    //     .then((QuerySnapshot querySnapshot) async {
    //   // await storage.setItem('clickedDetails', "");
    //   await storage.setItem('userPosts', jsonEncode(querySnapshot.docs));
    //   querySnapshot.docs.forEach((doc) {
    //     print(doc["Body"]);
    //   });
    // }
  }

  // Future getdata(id) async {
  //   FirebaseFirestore.instance
  //       .collection('users-details')
  //       .doc(id)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) async {
  //     if (documentSnapshot.exists) {
  //       await storage.setItem('userDetails', documentSnapshot.data());
  //       userDetails = await documentSnapshot.data();
  //       return userDetails;
  //     }
  //   });
  // }
  Future getFriendList(id) async {
    FirebaseFirestore.instance
        .collection('users-details')
        .doc(id)
        .collection('friendList')
        .get()
        .then(((QuerySnapshot querySnapshot) async {
      // var a = querySnapshot;

      // storage.setItem('alpha', a);
    }));
  }

  Stream<User> get user =>
      firebaseAuth.authStateChanges().map((event) => event);
}
