import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Groups extends StatefulWidget {
  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  final Stream<QuerySnapshot> _fb = FirebaseFirestore.instance.collection('Groups2').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fb,
      builder: BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

    }
  }
}
