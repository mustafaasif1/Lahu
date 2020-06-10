import 'package:flutter/material.dart';
import 'package:lahu/Shared/loading.dart';
import 'package:lahu/Services/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignIn googleAuth = GoogleSignIn();

  final AuthService _auth = AuthService();

  String _email, _password;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return loading
        ? Loader()
        : Scaffold(
            appBar: AppBar(
              title: Text('Sign In'),
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
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email),
                      ),
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
                      decoration: InputDecoration(
                        labelText: 'Passsword',
                        icon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 30.0),
                    // RaisedButton(
                    //   onPressed: () async {
                    //     if (_formKey.currentState.validate()) {
                    //       setState(() => loading = true);
                    //       dynamic result = await _auth
                    //           .signInWithEmailandPassword(_email, _password);
                    //       if (result == null) {
                    //         setState(() => error =
                    //             "Could not sign In woth those credentials");
                    //         loading = false;
                    //       } else {
                    //         Navigator.of(context).pop();
                    //       }
                    //     }
                    //   },
                    //   child: Text('Sign in'),
                    // ),
                    Container(
                      width: size.width * 0.6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 18, horizontal: 40),
                          color: Colors.red[800],
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.signInWithEmailandPassword(
                                      _email, _password);
                              if (result == null) {
                                setState(() => error =
                                    "Could not sign In woth those credentials");
                                loading = false;
                              } else {
                                Navigator.of(context).pop();
                              }
                            }
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    // RaisedButton(
                    //   onPressed: () async {
                    //     setState(() => loading = true);
                    //     dynamic result = await _auth.testSignInWithGoogle();
                    //     if (result == null) {
                    //       setState(() => error =
                    //           "Could not sign In with those credentials");
                    //       loading = false;
                    //     } else {
                    //       Navigator.of(context).pop();
                    //     }
                    //   },
                    //   child: Text('Login With Google'),
                    // ),

                    OutlineButton(
                      splashColor: Colors.grey,
                      onPressed: () async {
                        setState(() => loading = true);
                        dynamic result = await _auth.testSignInWithGoogle();
                        if (result == null) {
                          setState(() => error =
                              "Could not sign In with those credentials");
                          loading = false;
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      highlightElevation: 0,
                      borderSide: BorderSide(color: Colors.grey),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                                image: AssetImage("assets/GoogleLogo.png"),
                                height: 35.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
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
          );
  }

  // Future<void> signIn() async {
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState.save();
  //     try {
  //       AuthResult result = await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(email: _email, password: _password);
  //       FirebaseUser user = result.user;

  //       Navigator.of(context).pop();
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => Home()));
  //     } catch (e) {
  //       print(e.message);
  //     }
  //   }
  // }
}
