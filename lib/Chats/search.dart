import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lahu/Chats/chat_database.dart';
import 'package:lahu/Helper/constants.dart';

import 'conversation_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  QuerySnapshot searchSnapShot;

  initiateSearch() {
    DatabaseMethods().getUserByUsername(myController.text).then((val) {
      setState(() {
        searchSnapShot = val;
      });
    });
  }

  createChatRoomAndStartConversation(String userName) {
    if (userName != Constants.myName) {
      String chatRoomID = getChatRoomId(userName, Constants.myName);

      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomID,
      };

      DatabaseMethods().createChatRoom(chatRoomID, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomID)));
    } else {
      print("You can not message yourself");
    }
  }

  Widget searchTile({String userName, String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[Text(userName), Text(userEmail)],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatRoomAndStartConversation(userName);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red[800],
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                'Message',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchList() {
    return searchSnapShot != null
        ? Expanded(
            child: ListView.builder(
                itemCount: searchSnapShot.documents.length,
                itemBuilder: (context, index) {
                  return searchTile(
                    userName: searchSnapShot.documents[index].data["name"],
                    userEmail: searchSnapShot.documents[index].data["email"],
                  );
                }),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Users'),
      ),
      body: Container(
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: myController,
                    decoration: InputDecoration(hintText: "Search username"),
                  ),
                ),
                IconButton(
                  icon: new Icon(Icons.search),
                  onPressed: () {
                    initiateSearch();
                  },
                )
                // GestureDetector(
                //     onTap: () {
                //       print(searchTextEditingController.text);
                //       // databaseMethods
                //       //     .getUserByUsername(searchTextEditingController.text)
                //       //     .then((value) => print(value));
                //     },
                //     child: Icon(Icons.search))
              ],
            ),
          ),
          searchList()
        ]),
      ),
    );
  }
}

// class SearchTile extends StatelessWidget {
//   final String userName;
//   final String userEmail;

//   SearchTile({this.userName, this.userEmail});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//       child: Row(
//         children: <Widget>[
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[Text(userName), Text(userEmail)],
//           ),
//           Spacer(),
//           GestureDetector(
//             onTap: () {},
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.red[800],
//                   borderRadius: BorderRadius.circular(30)),
//               padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//               child: Text(
//                 'Message',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
