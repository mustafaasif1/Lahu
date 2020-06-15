import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lahu/Models/lahu_data_class.dart';
import 'package:lahu/Models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection for donor reference
  final CollectionReference lahuCollection =
      Firestore.instance.collection('donor_data');

  // collection for request donation reference
  final CollectionReference lahuRequestCollection =
      Firestore.instance.collection('request_data');

  // Update donor data
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

  // Update request blood data
  Future updateRequestDonationData(
      String name,
      String phoneNumber,
      String details,
      String bloodType,
      String city,
      String gender,
      String status,
      DateTime timeStamp) async {
    return await lahuRequestCollection.document(uid).setData({
      'name': name,
      'phoneNumber': phoneNumber,
      'details': details,
      'bloodType': bloodType,
      'city': city,
      'gender': gender,
      'status': status,
      'timeStamp': timeStamp,
    });
  }

  // Delete the donor data
  Future deleteUserData() async {
    await lahuCollection.document(uid).delete().catchError((onError) {
      print(onError);
    });
  }

  // Delete the request blood data
  Future deleteRequestBloodData() async {
    await lahuRequestCollection.document(uid).delete().catchError((onError) {
      print(onError);
    });
  }

  // lahu list form snapshot for donor
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

  // lahu list form snapshot for requesting blood
  List<LahuRequestObject> _lahuListFromSnapShotRequestBlood(
      QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return LahuRequestObject(
        name: doc.data['name'] ?? '',
        phoneNumber: doc.data['phoneNumber'] ?? '',
        details: doc.data['details'] ?? '',
        bloodType: doc.data['bloodType'] ?? '',
        city: doc.data['city'] ?? '',
        gender: doc.data['gender'] ?? '',
        status: doc.data['status'] ?? '',
        timeStamp: doc.data['timeStamp'].toDate() ?? null,
      );
    }).toList();
  }

  // Query and display the results
  Future<List<LahuDataObject>> getResults(String bloodType, String city) async {
    if (bloodType == 'All Bloodtypes' && city == 'All Cities') {
      dynamic result =
          await Firestore.instance.collection('donor_data').getDocuments();
      return _lahuListFromSnapShot(result);
    } else if (bloodType == 'All Bloodtypes') {
      dynamic result = await Firestore.instance
          .collection('donor_data')
          .where('city', isEqualTo: city)
          .getDocuments();
      return _lahuListFromSnapShot(result);
    } else if (city == 'All Cities') {
      dynamic result = await Firestore.instance
          .collection('donor_data')
          .where('bloodType', isEqualTo: bloodType)
          .getDocuments();
      return _lahuListFromSnapShot(result);
    } else {
      dynamic result = await Firestore.instance
          .collection('donor_data')
          .where('bloodType', isEqualTo: bloodType)
          .where('city', isEqualTo: city)
          .getDocuments();
      return _lahuListFromSnapShot(result);
    }
  }

  // Convert firebase object to AllDonorData object
  AllDonorData _userDatafromSnapShot(DocumentSnapshot snapshot) {
    return AllDonorData(
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

  // Convert firebase object to AllDonorData object
  AllRequestData _requestBloodDatafromSnapShot(DocumentSnapshot snapshot) {
    return AllRequestData(
      uid: uid,
      name: snapshot.data['name'],
      phoneNumber: snapshot.data['phoneNumber'],
      details: snapshot.data['details'],
      bloodType: snapshot.data['bloodType'],
      city: snapshot.data['city'],
      gender: snapshot.data['gender'],
      status: snapshot.data['status'],
      timeStamp: snapshot.data['timeStamp'].toDate(),
    );
  }

  // This stream is for all the users
  Stream<List<LahuDataObject>> get lahuData {
    return lahuCollection.snapshots().map(_lahuListFromSnapShot);
  }

  // This stream is for all the request Donations
  Stream<List<LahuRequestObject>> get requestData {
    return lahuRequestCollection
        .snapshots()
        .map(_lahuListFromSnapShotRequestBlood);
  }

  // This is for one specfic donor
  Stream<AllDonorData> get donorData1 {
    return lahuCollection.document(uid).snapshots().map(_userDatafromSnapShot);
  }

  // This is for one specfic blood request
  Stream<AllRequestData> get requestBloodData1 {
    return lahuRequestCollection
        .document(uid)
        .snapshots()
        .map(_requestBloodDatafromSnapShot);
  }
}
