import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SingleGroup extends StatefulWidget {
  final String id;
  final data;
  SingleGroup(this.id, this.data);
  @override
  _SingleGroupState createState() => _SingleGroupState();
}

class _SingleGroupState extends State<SingleGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['Name']),
        backgroundColor: HexColor("801818"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/1200x400.jpg"),
                          fit: BoxFit.cover)),
                  child: Container(
                    width: double.infinity,
                    height: 130,
                    child: Container(
                      alignment: Alignment(-0.9, 10),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.data['Img']),
                        radius: 60.0,
                      ),
                    ),
                  )),
            ),
            Row(
              children: [
                SizedBox(
                  width: 250,
                ),
                Icon(Icons.notifications),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text('Hello From Other Side')
          ],
        ),
      ),
    );
  }
}
