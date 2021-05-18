import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Login2 extends StatefulWidget {
  @override
  _Login2State createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var Email;
    var Password;
    return (Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(45),
            child: AppBar(
              // status bar color

              title: Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: HexColor("801818"),
            )),
        body: SafeArea(
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
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
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                            decoration: InputDecoration(hintText: "Email"),
                            onChanged: (value) {
                              Email = value;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                            decoration: InputDecoration(
                                hintText: "Password",
                                border: UnderlineInputBorder()),
                            obscureText: true,
                            onChanged: (value) {
                              Password = value;
                            }),
                      ),
                    ],
                  ))),
        )));
  }
}
