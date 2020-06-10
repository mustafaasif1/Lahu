import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lahu/Models/lahu_data_class.dart';
import 'package:lahu/Models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference lahuCollection =
      Firestore.instance.collection('user_data');

  Future updateUserData(
      String bloodType, String name, String city, String phoneNumber) async {
    return await lahuCollection.document(uid).setData({
      'bloodType': bloodType,
      'name': name,
      'city': city,
      'phoneNumber': phoneNumber
    });
  }

  // Delete the users data
  Future deleteUserData() async {
    await lahuCollection.document(uid).delete().catchError((onError) {
      print(onError);
    });
  }

  // lahu list form snapshot
  List<LahuDataObject> _lahuListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return LahuDataObject(
        name: doc.data['name'] ?? '',
        city: doc.data['city'] ?? '',
        bloodType: doc.data['bloodType'] ?? '',
        phoneNumber: doc.data['phoneNumber'] ?? '',
      );
    }).toList();
  }

  // Query and display the results
  Future<List<LahuDataObject>> getResults(String bloodType, String city) async {
    if (bloodType == 'All Bloodtypes' && city == 'All Cities') {
      dynamic result =
          await Firestore.instance.collection('user_data').getDocuments();
      return _lahuListFromSnapShot(result);
    } else if (bloodType == 'All Bloodtypes') {
      dynamic result = await Firestore.instance
          .collection('user_data')
          .where('city', isEqualTo: city)
          .getDocuments();
      return _lahuListFromSnapShot(result);
      
    } else if (city == 'All Cities') {
      dynamic result = await Firestore.instance
          .collection('user_data')
          .where('bloodType', isEqualTo: bloodType)
          .getDocuments();
      return _lahuListFromSnapShot(result);
    } else {
      dynamic result = await Firestore.instance
          .collection('user_data')
          .where('bloodType', isEqualTo: bloodType)
          .where('city', isEqualTo: city)
          .getDocuments();
      return _lahuListFromSnapShot(result);
    }
  }

  // userData from snapshot
  UserData _userDatafromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      city: snapshot.data['city'],
      bloodType: snapshot.data['bloodType'],
      phoneNumber: snapshot.data['phoneNumber'],
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
