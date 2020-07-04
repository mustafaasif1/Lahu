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

  createChatRoom(String chatRoomId, chatRoomMap, unseenMessages) async {
    await Firestore.instance
        .collection("chat_room")
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });

    await Firestore.instance
        .collection("unseen_messages")
        .document(chatRoomId)
        .setData(unseenMessages)
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
    return  Firestore.instance
        .collection("chat_room")
        .document(chatRoomID)
        .collection("chat")
        .orderBy("time")
        .snapshots();
  }

  getChatRooms(String userEmail) async {
    return  Firestore.instance
        .collection("chat_room")
        .where("users", arrayContains: userEmail)
        .snapshots();
  }

  getAllTheUnseenMessagesOfSpecificChatID(
      String chatRoomID, String myEmail, String othersEmail) async {
    dynamic result = Firestore.instance
        .collection('unseen_messages')
        .document(chatRoomID)
        .get()
        .then((value) {
      print(value.data["unseenMessages"][myEmail]);
    });

    
   

    
    return result;
  }

//     dynamic result = Firestore.instance
//         .collection("unseen_messages")
//         .document(chatRoomID)
//         .snapshots();

//         result.get() => then(function(document) {
//     print(document("name"));
// });

//     return result;

}
