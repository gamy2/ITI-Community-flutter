import 'package:flutter/material.dart';

class Profiledetails extends StatefulWidget {
  const Profiledetails(
      this.avatar, this.avatarCover, this.fName, this.lname, this.jTitel);
  final avatar;
  final avatarCover;
  final fName;
  final lname;
  final jTitel;
  @override
  _ProfiledetailsState createState() => _ProfiledetailsState();
}

class _ProfiledetailsState extends State<Profiledetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.avatarCover),
                    fit: BoxFit.cover)),
            child: Container(
              width: double.infinity,
              height: 130,
              child: Container(
                alignment: Alignment(0, 14),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.avatar),
                  radius: 60.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Text(
            widget.fName + " " + widget.lname,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
              height: 30,
              child: Center(
                child: Text(
                  widget.jTitel,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[600]),
                ),
              )),
        ],
      ),
    );
  }
}
