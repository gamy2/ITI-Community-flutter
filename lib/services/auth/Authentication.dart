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
  static var userID;

  var userDetails;
  final LocalStorage storage = new LocalStorage('iti');
  Future Login(String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseFirestore.instance
          .collection('users-details')
          .doc(authResult.user.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          storage.setItem('userDetails', documentSnapshot.data());
          userDetails = documentSnapshot.data();
          User user = authResult.user;
          // store.setItem('uid', user.uid);
          userID = user.uid;
          setLoading(false);
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
    FirebaseFirestore.instance
        .collection('users-details')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        storage.setItem('clickedDetails', documentSnapshot.data());
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  Stream<User> get user =>
      firebaseAuth.authStateChanges().map((event) => event);
}
