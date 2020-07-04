import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lahu/Chats/chat_database.dart';
import 'package:lahu/Helper/constants.dart';
import 'package:intl/intl.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  final String otherName;
  final String myName;
  ConversationScreen(this.chatRoomId, this.otherName, this.myName);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final myController = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  Stream chatMessagesStream;

  Widget chatMessageList() {
    return Expanded(
      child: StreamBuilder(
          stream: chatMessagesStream,
          builder: (context, snapshot) {
            Timer(
                Duration(milliseconds: 500),
                () => _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent));
            return snapshot.hasData
                ? ListView.builder(
                    controller: _scrollController,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return MessageTile(
                          snapshot.data.documents[index].data["message"],
                          snapshot.data.documents[index].data["sendBy"] ==
                              Constants.myEmail,
                          snapshot.data.documents[index].data["time"].toDate());
                    })
                : Container();
          }),
    );
  }

  sendMessage() {
    if (myController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": myController.text,
        "sendBy": Constants.myEmail,
        "time": DateTime.now(),
      };
      DatabaseMethods().addConversationMessage(widget.chatRoomId, messageMap);
      Firestore.instance
          .collection('unseen_messages')
          .document(widget.chatRoomId)
          .updateData({widget.otherName: FieldValue.increment(1)});
      myController.text = "";

      Timer(
          Duration(milliseconds: 500),
          () => _scrollController
              .jumpTo(_scrollController.position.maxScrollExtent));
    }
  }

  @override
  void initState() {
    DatabaseMethods().getConversationMessage(widget.chatRoomId).then((val) {
      setState(() {
        chatMessagesStream = val;
      });
    });
    Firestore.instance
        .collection('unseen_messages')
        .document(widget.chatRoomId)
        .updateData({Constants.myName.toString(): 0});

    Timer(
        Duration(milliseconds: 300),
        () => _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.otherName)),
      body: Container(
          child: Column(
        children: <Widget>[
          chatMessageList(),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              //decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
              color: Colors.grey[200],
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
                    icon: new Icon(Icons.send),
                    onPressed: () {
                      sendMessage();
                      Timer(
                          Duration(milliseconds: 100),
                          () => _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent));
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
  final DateTime timestamp;
  MessageTile(this.message, this.isSentByMe, this.timestamp);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: isSentByMe ? Colors.red[800] : Colors.grey[300],
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: <Widget>[
              Text(message,
                  style: isSentByMe
                      ? TextStyle(fontSize: 17, color: Colors.white)
                      : TextStyle(fontSize: 17, color: Colors.black)),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(DateFormat.yMd().add_jm().format(timestamp),
                    style: isSentByMe
                        ? TextStyle(fontSize: 10, color: Colors.grey[300])
                        : TextStyle(fontSize: 10, color: Colors.grey[600])),
              )
            ],
          )),
    );
  }
}
