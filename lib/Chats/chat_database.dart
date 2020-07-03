import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("user_data")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  getUserByEmail(String userEmail) async {
    return await Firestore.instance
        .collection("user_data")
        .where("email", isEqualTo: userEmail)
        .getDocuments();
  }

  createChatRoom(String chatRoomId, chatRoomMap) async {
    await Firestore.instance
        .collection("chat_room")
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessage(String chatRoomID, messageMap) async {
    await Firestore.instance
        .collection("chat_room")
        .document(chatRoomID)
        .collection("chat")
        .add(messageMap)
        .catchError((onError) => print(onError.toString()));
  }

  getConversationMessage(String chatRoomID) async {
    return await Firestore.instance
        .collection("chat_room")
        .document(chatRoomID)
        .collection("chat")
        .orderBy("time")
        .snapshots();
  }

  getChatRooms(String userName) async {
    return await Firestore.instance
        .collection("chat_room")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
