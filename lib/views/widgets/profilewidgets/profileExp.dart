import 'package:flutter/material.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/views/widgets/profilewidgets/profileExpCard.dart';

class profileExp extends StatefulWidget {
  profileExp(this.experiences, this.uid);

  List experiences;

  final uid;
  @override
  _profileExpState createState() => _profileExpState();
}

class _profileExpState extends State<profileExp> {
  var img =
      "https://firebasestorage.googleapis.com/v0/b/iti-community.appspot.com/o/221-2211998_contract-clipart-hired-experience-vector.png?alt=media&token=46043915-0b7e-4c7b-88e2-afbbf0a91742";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Experiences",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
                textAlign: TextAlign.left,
              ),
            ),
          ]),
          (widget.experiences.length != 0
              ? Column(
                  children: widget.experiences
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (e['companyName'] != null
                                            ? e['companyName']
                                            : " "),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Column(
                                        children: [
                                          Text("Location : " +
                                              (e['location'] != null
                                                  ? e['location']
                                                  : " ")),
                                          Text("from : " +
                                              (e['from'] != null
                                                  ? e['from']
                                                  : "") +
                                              " " +
                                              "to:" +
                                              (e['to'] != null
                                                  ? e['to']
                                                  : "now")),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, top: 5),
                                            child: Text('description' +
                                                (e['description'] != null
                                                    ? e['description']
                                                    : " ")),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 1,
                    ),
                    Column(children: [
                      Text("SORRY , This Account Has No Experiences"),
                      Container(
                        child: Image.network(img),
                        width: 300,
                      )
                    ]),
                    SizedBox(
                      width: 1,
                    ),
                  ],
                )),
          Row(children: <Widget>[
            Expanded(child: Divider()),
            Expanded(child: Divider()),
          ]),
          widget.uid == AuthServices.userID
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: InkWell(
                          child: Text(
                            "+",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                  ],
                )
              : Text("")
        ],
      ),
    );
  }
}
