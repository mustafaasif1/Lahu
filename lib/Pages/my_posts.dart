import 'package:flutter/material.dart';
import 'package:lahu/Models/user.dart';
import 'package:lahu/Pages/my_posts_inside.dart';
// import 'package:lahu/Services/auth.dart';
import 'package:lahu/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:lahu/Models/lahu_data_class.dart';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<List<LahuRequestObject>>.value(
      value: DatabaseService(uid: user.uid).allPostsOfRequestBySinglePerson,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Posts',
          ),
          elevation: 0.0,
        ),
        body: MyPostsInside(),
      ),
    );
  }
}
