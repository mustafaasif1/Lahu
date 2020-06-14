import 'package:flutter/material.dart';
import 'package:lahu/Models/lahu_data_class.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
        child: InkWell(
          onTap: () => Alert(
            context: context,
            //type: AlertType.error,
            title: "Are you sure you want to call ${lahuObject.name}?",
            buttons: [
              DialogButton(
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  String number = "tel://${lahuObject.phoneNumber}";
                  launch(number);
                },
                width: 120,
              ),
            ],
          ).show(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 10.0, 8.0, 10.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 35.0,
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
              subtitle: Text(
                  '${lahuObject.gender} - ${lahuObject.city} - ${lahuObject.phoneNumber}'),
            ),
          ),
        ),
      ),
    );
  }
}
