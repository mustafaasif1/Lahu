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
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red,
          ),
          title: Text(lahuObject.name),
          subtitle: Text(
              'The blood type is ${lahuObject.bloodType} and location is ${lahuObject.location}'),
        ),
      ),
    );
  }
}
