import 'package:flutter/material.dart';
import 'package:lahu/Shared/loading.dart';
import 'package:lahu/Services/auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PasswordReset extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final AuthService _auth = AuthService();

  String _email;
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
                              'Enter email to reset Password ',
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
                      SizedBox(height: 40.0),
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
                                await _auth.resetPassword(_email);
                                Alert(
                                  context: context,
                                  title:
                                      "An email has been sent to your account to change your password",
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "Okay",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      width: 120,
                                    ),
                                  ],
                                ).show();
                              }
                            },
                            child: Text(
                              'Reset Password',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
