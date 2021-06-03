import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Function togglescreen;

  const Login({Key key, this.togglescreen}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();
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
    final loginProvider = Provider.of<AuthServices>(context);
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
          child: SingleChildScrollView(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 60),
                            child: Container(
                                child: Image(
                              image: AssetImage('assets/images/iti1.png'),
                              height: 160,
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                                controller: _emailController,
                                validator: (val) => val.isNotEmpty
                                    ? null
                                    : "please enter email",
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    prefixIcon: Icon(Icons.mail)),
                                onChanged: (value) {
                                  Email = value;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                                controller: _passwordController,
                                validator: (val) => val.isNotEmpty
                                    ? null
                                    : "please enter password",
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    prefixIcon: Icon(Icons.vpn_key),
                                    border: UnderlineInputBorder()),
                                obscureText: true,
                                onChanged: (value) {
                                  Password = value;
                                }),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          InkWell(
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
                            onTap: () async {
                              if (_formkey.currentState.validate()) {
                                print("Email: ${_emailController.text}");
                                print("Email: ${_passwordController.text}");
                                await loginProvider.Login(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim());
                              }
                            },
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          // InkWell(
                          //   onTap: () {},
                          //   child: Text(
                          //     "Forget Password?",
                          //     style: TextStyle(
                          //         color: HexColor("801818"),
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                          // SizedBox(height: 22),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text("Dont Have Any Account?"),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     InkWell(
                          //       child: Text("Rgister",
                          //           style: TextStyle(
                          //               color: HexColor("801818"),
                          //               fontWeight: FontWeight.bold)),
                          //       onTap: () => widget.togglescreen(),
                          //     )
                          //   ],
                          // )
                        ],
                      ),
                    ))),
          ),
        )));
  }
}
