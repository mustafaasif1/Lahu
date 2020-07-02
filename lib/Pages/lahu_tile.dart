import 'package:flutter/material.dart';
import 'package:lahu/Models/lahu_data_class.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LahuTile extends StatelessWidget {
  final LahuRequestObject lahuObject;
  LahuTile({this.lahuObject});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 200,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                trailing: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.phone),
                      tooltip: 'Call this person',
                      onPressed: () => Alert(
                        context: context,
                        //type: AlertType.error,
                        title:
                            "Are you sure you want to call ${lahuObject.name}?",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Yes",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              String number = "tel://${lahuObject.phoneNumber}";
                              launch(number);
                            },
                            width: 120,
                          ),
                        ],
                      ).show(),
                    ), // icon-1
                  ],
                ),
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
    // return Padding(
    //   padding: EdgeInsets.only(top: 8.0),
    //   child: Card(
    //     elevation: 0.0,
    //     shape:
    //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    //     margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
    //     child: InkWell(
    //       onTap: () => Alert(
    //         context: context,
    //         //type: AlertType.error,
    //         title: "Are you sure you want to call ${lahuObject.name}?",
    //         buttons: [
    //           DialogButton(
    //             child: Text(
    //               "Yes",
    //               style: TextStyle(color: Colors.white, fontSize: 20),
    //             ),
    //             onPressed: () {
    //               String number = "tel://${lahuObject.phoneNumber}";
    //               launch(number);
    //             },
    //             width: 120,
    //           ),
    //         ],
    //       ).show(),
    //       child: Padding(
    //         padding: const EdgeInsets.fromLTRB(5.0, 10.0, 8.0, 10.0),
    //         child: ListTile(
    //           leading: CircleAvatar(
    //             radius: 35.0,
    //             backgroundColor: Colors.red[600],
    //             child: Text(
    //               '${lahuObject.bloodType}',
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 20.0,
    //                   color: Colors.white),
    //             ),
    //           ),
    //           title: Text(
    //             lahuObject.name,
    //             style: TextStyle(
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           subtitle: Text(
    //               '${lahuObject.gender} - ${lahuObject.city} - ${lahuObject.phoneNumber}'),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

// class CustomCard extends StatefulWidget {
//   @override
//   _CustomCardState createState() => _CustomCardState();
// }

// class _CustomCardState extends State<CustomCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         color: Colors.pink,
//         elevation: 10,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             ListTile(
//               leading: CircleAvatar(
//                 radius: 35.0,
//                 backgroundColor: Colors.red[600],
//                 child: Text(
//                   '${lahuObject.bloodType}',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20.0,
//                       color: Colors.white),
//                 ),
//               ),
//               title: Text(
//                 lahuObject.name,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               subtitle: Text(
//                   '${lahuObject.gender} - ${lahuObject.city} - ${lahuObject.phoneNumber}'),
//             ),
//             // ButtonTheme.bar(
//   child: ButtonBar(
//     children: <Widget>[
//       FlatButton(
//         child: const Text('Edit',
//             style: TextStyle(color: Colors.white)),
//         onPressed: () {},
//       ),
//       FlatButton(
//         child: const Text('Delete',
//             style: TextStyle(color: Colors.white)),
//         onPressed: () {},
//       ),
//     ],
//   ),
// ),
//         ],
//       ),
//     ),
//   );
// }

// @override
// Widget build(BuildContext context) {
//   return Card(
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//     margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
//     child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CircleAvatar(
//               radius: 35.0,
//               backgroundColor: Colors.red[600],
//               child: Text(
//                 'A+',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20.0,
//                     color: Colors.white),
//               ),
//             ),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             // crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Mustafa Asif',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16.0,
//                 ),
//                 maxLines: null,
//               ),
//               Text(
//                 'Male - Karachi - Corona Recovered',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                 ),
//                 maxLines: null,
//               ),
//               Text(
//                 'My mother is critical illl annd is admitted in Liaquat National hospital',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                 ),
//                 maxLines: null,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
//}
