import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final userDetails = authServices.storage.getItem("userDetails");

    return Scaffold(
      backgroundColor: HexColor("e4e1e1"),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                  height: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(userDetails["avatar"]),
                            radius: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
