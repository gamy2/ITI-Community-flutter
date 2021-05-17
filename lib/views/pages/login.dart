import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/services/auth.dart';
import 'package:iti_community_flutter/views/widgets/login_widgets/login_img.dart';

class login extends StatefulWidget {
  final String title;
  login(this.title);
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  var Email;
  var Password;
  final AuthService _auth = AuthService();
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
                onTap: () async {
                  dynamic login = await _auth.signInEmail(Email, Password);
                  if (login == null) {
                    print('error');
                  } else {
                    print(login);
                  }
                },
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
