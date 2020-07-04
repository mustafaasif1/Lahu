class LahuDataObject {
  final String name;
  final String phoneNumber;
  final String bloodType;
  final String city;
  final String gender;
  final String status;
  final DateTime recoveryDate;
  final DateTime timeStamp;

  LahuDataObject(
      {this.name,
      this.phoneNumber,
      this.bloodType,
      this.city,
      this.gender,
      this.status,
      this.recoveryDate,
      this.timeStamp});
}

class LahuRequestObject {
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

  LahuRequestObject(
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
      this.myEmail});
}
