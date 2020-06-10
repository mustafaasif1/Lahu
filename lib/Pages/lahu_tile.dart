import 'package:flutter/material.dart';
import 'package:lahu/Models/lahu_data_class.dart';

class LahuTile extends StatelessWidget {
  final LahuDataObject lahuObject;
  LahuTile({this.lahuObject});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.red,
              child: Text(
                '${lahuObject.bloodType}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white),
              ),
            ),
            title: Text(lahuObject.name),
            subtitle: Text(
                'City is ${lahuObject.city} and phone number is ${lahuObject.phoneNumber}'),
          ),
        ),
      ),
    );
  }
}
