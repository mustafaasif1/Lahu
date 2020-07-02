import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lahu/Chats/search.dart';

class ChatHomePage extends StatefulWidget {
  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Chats')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(title: Text('My Chats')),
    //   body: Container(
    //     child: StreamBuilder(
    //       stream: Firestore.instance.collection('user_data').snapshots(),
    //       builder: (context, snapshot) {
    //         if (!snapshot.hasData) {
    //           return Center(
    //             child: CircularProgressIndicator(
    //                 //valueColor: AlwaysStoppedAnimation<Color>(themeColor),
    //                 ),
    //           );
    //         } else {
    //           return ListView.builder(
    //               padding: EdgeInsets.all(10.0),
    //               itemCount: snapshot.data.documents.length,
    //               itemBuilder: (BuildContext context, int index) =>
    //                   Text('${snapshot.data.documents[index]['name']}'));
    //         }
    //       },
    //     ),
    //   ),
    // );
  }
}
