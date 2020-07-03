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
                  return ChatRoomsTile(
                      snapshot.data.documents[index].data["chatroomId"]
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, ""),
                      snapshot.data.documents[index].data["chatroomId"]);
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
    databaseMethods.getChatRooms(Constants.myName).then((val) {
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

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoom;

  ChatRoomsTile(this.userName, this.chatRoom);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(chatRoom)));
      },
      child: Container(
          child: Row(
        children: <Widget>[
          SizedBox(
            width: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(userName),
          ),
        ],
      )),
    );
  }
}
