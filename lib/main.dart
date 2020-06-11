import 'package:flutter/material.dart';
import 'package:lahu/Models/colors.dart';
import 'package:lahu/Services/auth.dart';
import 'package:lahu/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:lahu/Models/user.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData(
    primarySwatch: generateMaterialColor(Palette.primary),
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: Wrapper(),
      ),
    );
  }
}
