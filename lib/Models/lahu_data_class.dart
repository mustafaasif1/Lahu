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
  final String name;
  final String phoneNumber;
  final String details;
  final String bloodType;
  final String city;
  final String gender;
  final String status;
  final DateTime timeStamp;

  LahuRequestObject(
      {this.name,
      this.phoneNumber,
      this.details,
      this.bloodType,
      this.city,
      this.gender,
      this.status,
      this.timeStamp});
}
