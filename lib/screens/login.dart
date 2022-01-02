import 'package:flutter/material.dart';
import 'package:notes_sample/screens/home.dart';
import 'package:notes_sample/utils/firebase_utils.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;

  // void _signInWithGoogle() async {
  //   setState(() {
  //     loading = true;
  //   });

  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   final userCred =
  //       await FirebaseAuth.instance.signInWithCredential(credential);

  //   if (userCred.user != null) {
  //     //logged in
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, MainScreen.routeName, (route) => false);
  //   }

  //   setState(() {
  //     loading = false;
  //   });
  // }

  void _onPressLogin() async {
    try {
      setState(() {
        loading = true;
      });

      final loggedIn = await FirebaseUserUtils.signInWithGoogle();

      if (loggedIn) {
        //logged in
        Navigator.pushNamedAndRemoveUntil(
            context, MainScreen.routeName, (route) => false);
      }
      
      setState(() {
        loading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Login"),
        ),
        body: Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                shadowColor: Colors.greenAccent,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: const Size(100, 40), //////// HERE
              ),
              onPressed: loading ? null : _onPressLogin,
              child: loading
                  ? const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Text("LOGIN")),
        ));
  }
}
