import 'package:flutter/material.dart';

class profileExpCard extends StatefulWidget {
  profileExpCard(this.exp);
  final exp;
  @override
  _profileExpCardState createState() => _profileExpCardState();
}

class _profileExpCardState extends State<profileExpCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (widget.exp['companyName'] =
                      null ? " " : widget.exp['companyName']),
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("Location : " +
                          (widget.exp['location'] =
                              null ? " " : widget.exp['location'])),
                      Text("from : " +
                          widget.exp['from'] +
                          " " +
                          "to:" +
                          (widget.exp['to'] = null ? "now" : widget.exp['to'])),
                      Text((widget.exp['description'] =
                          null ? "" : widget.exp['description']))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
