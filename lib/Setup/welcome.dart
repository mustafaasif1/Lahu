import 'package:flutter/material.dart';
import 'package:lahu/SetUp/signIn.dart';
import 'package:lahu/SetUp/signUp.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Lahu')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: navigateToSignIn,
                child: Text('Sign in'),
              ),
              RaisedButton(
                onPressed: navigateToSignUp,
                child: Text('Sign Up'),
              )
            ],
          ),
        ));
  }

  void navigateToSignIn() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void navigateToSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }
}
