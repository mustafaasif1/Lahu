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
      String name,
      String phoneNumber,
      String bloodType,
      String city,
      String gender,
      String status,
      DateTime recoveryDate,
      DateTime timeStamp) async {
    return await lahuCollection.document(uid).setData({
      'name': name,
      'phoneNumber': phoneNumber,
      'bloodType': bloodType,
      'city': city,
      'gender': gender,
      'status': status,
      'recoveryDate': recoveryDate,
      'timeStamp': timeStamp,
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
        phoneNumber: doc.data['phoneNumber'] ?? '',
        bloodType: doc.data['bloodType'] ?? '',
        city: doc.data['city'] ?? '',
        gender: doc.data['gender'] ?? '',
        status: doc.data['status'] ?? '',
        recoveryDate: doc.data['recoveryDate'].toDate() ?? null,
        timeStamp: doc.data['timeStamp'].toDate() ?? null,
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
      gender: snapshot.data['gender'],
      status: snapshot.data['status'],
      recoveryDate: snapshot.data['recoveryDate'].toDate(),
      timeStamp: snapshot.data['timeStamp'].toDate(),
    );
  }

  // This stream is for all the users
  Stream<List<LahuDataObject>> get lahuData {
    return lahuCollection.snapshots().map(_lahuListFromSnapShot);
  }

  // This is for one specfic user
  Stream<UserData> get userData {
    return lahuCollection.document(uid).snapshots().map(_userDatafromSnapShot);
  }
}
