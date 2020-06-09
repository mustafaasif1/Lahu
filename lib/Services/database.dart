import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lahu/Models/lahu_data_class.dart';
import 'package:lahu/Models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference lahuCollection =
      Firestore.instance.collection('user_data');

  Future updateUserData(String bloodType, String name, String location) async {
    return await lahuCollection
        .document(uid)
        .setData({'bloodType': bloodType, 'name': name, 'location': location});
  }

  // lahu list form snapshot
  List<LahuDataObject> _lahuListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return LahuDataObject(
        name: doc.data['name'] ?? '',
        location: doc.data['location'] ?? '',
        bloodType: doc.data['bloodType'] ?? '',
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDatafromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      location: snapshot.data['location'],
      bloodType: snapshot.data['bloodType'],
    );
  }

  // get user doc stream
  Stream<List<LahuDataObject>> get lahuData {
    return lahuCollection.snapshots().map(_lahuListFromSnapShot);
  }

  Stream<UserData> get userData {
    return lahuCollection.document(uid).snapshots().map(_userDatafromSnapShot);
  }
}
