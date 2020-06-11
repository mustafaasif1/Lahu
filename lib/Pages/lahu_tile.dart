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
        elevation: 0.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 10.0, 8.0, 10.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.red[600],
              child: Text(
                '${lahuObject.bloodType}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white),
              ),
            ),
            title: Text(
              lahuObject.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('${lahuObject.gender} - ${lahuObject.city} - ${lahuObject.phoneNumber}'),
          ),
        ),
      ),
    );
  }
}
