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

  String _email, _password, _confirmPassword;
  final _formKey = GlobalKey<FormState>();
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return loading
        ? Loader()
        : Scaffold(
            appBar: AppBar(
              title: Text(''),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
                            child: Text(
                              'Sign up ',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
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
                        decoration: InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.email),
                        ),
                      ),
                      TextFormField(
                        validator: (input) {
                          if (input.length < 6) {
                            return 'Password has to at least six characters';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (input) {
                          setState(() => _password = input);
                        },
                        decoration: InputDecoration(
                          labelText: 'Passsword',
                          icon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),
                      TextFormField(
                        validator: (input) {
                          if (_confirmPassword != _password) {
                            return 'Passwords do not match';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (input) {
                          setState(() => _confirmPassword = input);
                        },
                        decoration: InputDecoration(
                          labelText: 'Confirm Passsword',
                          icon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 40.0),
                      // RaisedButton(
                      //   onPressed: () async {
                      //     if (_formKey.currentState.validate()) {
                      //       setState(() => loading = true);
                      //       dynamic result = await _auth
                      //           .registerWithEmailandPassword(_email, _password);
                      //       if (result == null) {
                      //         setState(
                      //             () => error = "Please supply a valid email");
                      //         loading = false;
                      //       } else {
                      //         Navigator.of(context).pop();
                      //       }
                      //     }
                      //   },
                      //   child: Text('Sign Up'),
                      // ),
                      Container(
                        width: size.width * 0.6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            color: Colors.red[800],
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerWithEmailandPassword(
                                        _email, _password);
                                if (result == null) {
                                  setState(() =>
                                      error = "Please supply a valid email");
                                  loading = false;
                                } else {
                                  Navigator.of(context).pop();
                                }
                              }
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
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
