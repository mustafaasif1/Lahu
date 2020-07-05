class User {
  final String uid;

  User({this.uid});
}

class AllDonorData {
  final String uid;
  final String name;
  final String phoneNumber;
  final String bloodType;
  final String city;
  final String gender;
  final String status;
  final DateTime recoveryDate;
  final DateTime timeStamp;
  final String myName;
  final String myEmail;
  final bool hidePhoneNumber;

  AllDonorData(
      {this.uid,
      this.name,
      this.phoneNumber,
      this.bloodType,
      this.city,
      this.gender,
      this.status,
      this.recoveryDate,
      this.timeStamp,
      this.myName,
      this.myEmail,
      this.hidePhoneNumber});
}

class AllRequestData {
  final String uid;
  final String name;
  final String phoneNumber;
  final String details;
  final String bloodType;
  final String city;
  final String gender;
  final String status;
  final DateTime timeStamp;
  final String myName;
  final String myEmail;
  final bool hidePhoneNumber;

  AllRequestData(
      {this.uid,
      this.name,
      this.phoneNumber,
      this.details,
      this.bloodType,
      this.city,
      this.gender,
      this.status,
      this.timeStamp,
      this.myName,
      this.myEmail,
      this.hidePhoneNumber});
}
