import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("user_data")
        .where("name", isEqualTo: username)
        .getDocuments();
  }
}
