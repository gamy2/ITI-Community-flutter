import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Spinner extends StatefulWidget {
  Spinner({Key key}) : super(key: key);

  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
            ),
            height: 40.0,
            width: 40.0,
          )
        ],
      ),
    ));
  }
}
