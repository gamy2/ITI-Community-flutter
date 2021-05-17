import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //sign in with email and password
  Future signInEmail(signInEmail, singInPassword) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: signInEmail, password: singInPassword);
      var user = result.user;
      print(user.toString());
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //reg

  // sign out

}
