import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class login3 extends StatefulWidget {
  final String title;
  login3(this.title);
  @override
  _login3State createState() => _login3State();
}

class _login3State extends State<login3> {
  var Email;
  var Password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: HexColor("801818"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Container(
                    child: Image(
                  image: AssetImage('assets/images/iti1.png'),
                  height: 100,
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                    decoration: InputDecoration(hintText: "Email"),
                    onChanged: (value) {
                      Email = value;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: "Password", border: UnderlineInputBorder()),
                    obscureText: true,
                    onChanged: (value) {
                      Password = value;
                    }),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: SizedBox(
                    width: 300,
                    height: 40,
                    child: Card(
                      color: HexColor("801818"),
                      child: Center(
                        child: Text("Sing In",
                            style: TextStyle(
                                color: HexColor("e4e1e1"),
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22.0),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                        color: HexColor("801818"), fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
