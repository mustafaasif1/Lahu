import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lahu/Chats/chat_database.dart';
import 'package:lahu/Chats/conversation_screen.dart';
import 'package:lahu/Chats/search.dart';
import 'package:lahu/Helper/constants.dart';
import 'package:lahu/Helper/helper_functions.dart';

class ChatHomePage extends StatefulWidget {
  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  Stream chatRoomStream;

  DatabaseMethods databaseMethods = DatabaseMethods();

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  String otherName = Constants.myName ==
                          snapshot.data.documents[index].data["usersName"][1]
                      ? snapshot.data.documents[index].data["usersName"][0]
                      : snapshot.data.documents[index].data["usersName"][1];
                  return ChatRoomsTile(
                    snapshot.data.documents[index].data["chatroomId"]
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myEmail, ""),
                    snapshot.data.documents[index].data["chatroomId"],
                    otherName,
                    Constants.myName,
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    Constants.myEmail = await HelperFunctions.getUserEmailSharedPreference();
    await databaseMethods.getChatRooms(Constants.myEmail).then((val) {
      setState(() {
        chatRoomStream = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Chats')),
      body: chatRoomList(),
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

class ChatRoomsTile extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String chatRoom;
  final String myName;

  ChatRoomsTile(this.userEmail, this.chatRoom, this.userName, this.myName);

  @override
  _ChatRoomsTileState createState() => _ChatRoomsTileState();
}

class _ChatRoomsTileState extends State<ChatRoomsTile> {
  //int unseenMessages;

  @override
  void initState() {
    //getUnseenMessages();
    super.initState();
  }

  // getUnseenMessages() async {
  //   await Firestore.instance
  //       .collection('unseen_messages')
  //       .document(widget.chatRoom)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       unseenMessages = value.data[Constants.myName];

  //       print(unseenMessages);
  //     });

  //     //print(value.data["unseenMessages"][Constants.myEmail]);
  //   });
  // }

//   Widget build(BuildContext context) {
//   return StreamBuilder(
//       stream: Firestore.instance
//         .collection('unseen_messages')
//         .document(widget.chatRoom).snapshots(),
//       builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (!snapshot.hasData) {
//           return Text("Loading");
//         }
//         var userDocument = snapshot.data;
//         return Text(userDocument["name"]);
//       }
//   );
// }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('unseen_messages')
            .document(widget.chatRoom)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          var userDocument = snapshot.data;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConversationScreen(widget.chatRoom,
                      this.widget.userName, this.widget.myName),
                ),
              );
            },
            child: ListTile(
              title: Text(widget.userName),
              subtitle: Text(widget.userEmail),
              leading: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.red[600],
                  child: snapshot.hasData
                      ? Text(
                          userDocument[Constants.myName].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white),
                        )
                      : null),
              trailing: Icon(Icons.arrow_right),
            ),
          );
        });
  }
}
