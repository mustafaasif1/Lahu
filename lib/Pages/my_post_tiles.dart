import 'package:flutter/material.dart';
import 'package:lahu/Models/lahu_data_class.dart';

class MyPostTiles extends StatelessWidget {
  final LahuRequestObject lahuObject;
  MyPostTiles({this.lahuObject});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 200,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                // trailing: Wrap(
                //   spacing: 12, // space between two icons
                //   children: <Widget>[
                //     IconButton(
                //       icon: Icon(Icons.delete),
                //       tooltip: 'Delete post',
                //       onPressed: () => Alert(
                //         context: context,
                //         //type: AlertType.error,
                //         title: "Are you sure you want to delete this post?",
                //         buttons: [
                //           DialogButton(
                //             child: Text(
                //               "Yes",
                //               style:
                //                   TextStyle(color: Colors.white, fontSize: 20),
                //             ),
                //             onPressed: () {},
                //             width: 120,
                //           ),
                //         ],
                //       ).show(),
                //     ), // icon-1
                //   ],
                // ),
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
                subtitle:
                    Text('${lahuObject.city} - ${lahuObject.phoneNumber}'),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 2.0),
                  child: Text(
                    'Required Blood: ${lahuObject.status} person',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 4.0),
                  child: Text(
                    'Gender of patient: ${lahuObject.gender}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
                  child: Text('${lahuObject.details}'
                      // 'Hello my name is mustafa asif my mother is critically ill. Please help her. she is in liaquat national hospital. She is in Liaquat national hosital. Please reach me on my number',
                      // style: TextStyle(
                      //   fontSize: 16.0,
                      // ),
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
