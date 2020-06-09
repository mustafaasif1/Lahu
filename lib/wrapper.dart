import 'package:flutter/material.dart';
import 'package:lahu/Pages/home.dart';
import 'package:lahu/SetUp/welcome.dart';
import 'package:lahu/Models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return WelcomePage();
    } else {
      return Home();
    }
  }
}
