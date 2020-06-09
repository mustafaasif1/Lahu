import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:lahu/Shared/loading.dart';
import 'package:lahu/Services/auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _auth = AuthService();

  String _email, _password;
  final _formKey = GlobalKey<FormState>();
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loader()
        : Scaffold(
            appBar: AppBar(
              title: Text('Sign Up'),
            ),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Please type an email';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (input) {
                        setState(() => _email = input);
                      },
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                      validator: (input) {
                        if (input.length < 6) {
                          return 'Password has to atleast six characters';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (input) {
                        setState(() => _password = input);
                      },
                      decoration: InputDecoration(labelText: 'Passsword'),
                      obscureText: true,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailandPassword(_email, _password);
                          if (result == null) {
                            setState(
                                () => error = "Please supply a valid email");
                            loading = false;
                          } else {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: Text('Sign Up'),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  // Future<void> signUp() async {
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState.save();
  //     try {
  //       AuthResult result = await FirebaseAuth.instance
  //           .createUserWithEmailAndPassword(email: _email, password: _password);
  //       FirebaseUser user = result.user;
  //       user.sendEmailVerification();
  //       Navigator.of(context).pop();
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => LoginPage()));
  //     } catch (e) {
  //       print(e.message);
  //     }
  //   }
  // }
}
