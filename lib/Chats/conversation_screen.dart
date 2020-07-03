import 'package:flutter/material.dart';
import 'package:lahu/Chats/chat_database.dart';
import 'package:lahu/Helper/constants.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final myController = TextEditingController();

  Stream chatMessagesStream;

  Widget chatMessageList() {
    return StreamBuilder(
        stream: chatMessagesStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                        snapshot.data.documents[index].data["message"],
                        snapshot.data.documents[index].data["sendBy"] ==
                            Constants.myName);
                  })
              : Container();
        });
  }

  sendMessage() {
    if (myController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": myController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      DatabaseMethods().addConversationMessage(widget.chatRoomId, messageMap);
      myController.text = "";
    }
  }

  @override
  void initState() {
    DatabaseMethods().getConversationMessage(widget.chatRoomId).then((val) {
      setState(() {
        chatMessagesStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Container(
          child: Stack(
        children: <Widget>[
          chatMessageList(),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(hintText: "Enter message.."),
                    ),
                  ),
                  IconButton(
                    icon: new Icon(Icons.message),
                    onPressed: () {
                      sendMessage();
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
          )
        ],
      )),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  MessageTile(this.message, this.isSentByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: isSentByMe ? Colors.red[800] : Colors.blue,
              borderRadius: BorderRadius.circular(20)),
          child: Text(message,
              style: TextStyle(fontSize: 17, color: Colors.white))),
    );
  }
}
