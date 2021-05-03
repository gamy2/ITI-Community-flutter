import 'package:flutter/material.dart';

class Imgban extends StatelessWidget {
  String imgStr;
  Imgban(this.imgStr);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image(
      image: AssetImage(imgStr),
      height: 140,
    ));
  }
}
