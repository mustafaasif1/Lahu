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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(title: Text('')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image(
                  image: AssetImage('assets/LahuLogo.png'),
                  width: 300,
                  height: 200,
                ),
              ),
              Text(
                'Lahu ',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 50.0),
                    child: Text(
                      'One platform to donate and find blood plasma for Covid 19 Patients in Pakistan ',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              Container(
                width: size.width * 0.7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: Colors.red[800],
                    onPressed: navigateToSignIn,
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
              SizedBox(
                height: 20,
              ),
              // Container(
              //   width: size.width * 0.7,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(29),
              //     child: FlatButton(
              //       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              //       color: Colors.white,
              //       onPressed: navigateToSignUp,
              //       child: Text(
              //         'Sign up',
              //         style: TextStyle(
              //           fontSize: 17,
              //           color: Colors.black,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              Container(
                width: size.width * 0.7,
                child: OutlineButton(
                  color: Colors.white,
                  splashColor: Colors.grey,
                  onPressed: navigateToSignUp,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  highlightElevation: 0,
                  borderSide: BorderSide(color: Colors.grey),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // RaisedButton(
              //   onPressed: navigateToSignIn,
              //   child: Text('Sign in'),
              // ),
              // RaisedButton(
              //   onPressed: navigateToSignUp,
              //   child: Text(
              //     'Sign Up',
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold, color: Colors.white),
              //   ),
              // )
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
