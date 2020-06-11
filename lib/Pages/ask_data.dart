import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lahu/Models/user.dart';
import 'package:lahu/Services/database.dart';

class AskData extends StatefulWidget {
  // final Function askdata;

  // AskData({this.askdata});

  @override
  _AskDataState createState() => _AskDataState();
}

class _AskDataState extends State<AskData> {
  final _formKey = GlobalKey<FormState>();
  final List<String> blood = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  final List<String> city = [
    'Karachi',
    'Lahore',
    'Islamabad',
    'Multan',
    'Hyderabad',
    'Peshawar',
    'Quetta',
    'Sukkur',
    'Faisalabad',
    'Rawalpindi',
    'Bahawalpur',
    'Sardodha',
    'Sialkot',
    'Larkana',
    'Sheikupura',
    'Rahim Yar Khan',
    'Jhang',
    'Dera Ghazi Khan',
    'Gujrat',
    'Sahiwal',
    'Wah Cantonment',
    'Mardan',
    'Kasur',
    'Abbotabad'
  ];

  String _currentGender;
  String _currentName;
  String _currentPhoneNumber;
  String _currentBloodType;
  String _currentCity;

  void _handleRadioValueChange1(String value) {
    setState(() {
      _currentGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    city.sort();

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          if (!snapshot.hasData) {
            UserData userData = snapshot.data;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Are you Corona recovered and want to donate blood? Enter your details below',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Center(
                    //   child: const Text(
                    //       'Are you Corona recovered and want to donate blood?!'),
                    // ),
                    // Center(
                    //   child: const Text('Enter your details below'),
                    // ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Name',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter your number';
                        } else if (val.length != 11) {
                          return 'Please enter correct number';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) =>
                          setState(() => _currentPhoneNumber = val),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone),
                        hintText: 'Phone Number',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField<String>(
                      hint: Text('Select Blood Group'),
                      value: _currentBloodType,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (String newValue) {
                        setState(() {
                          _currentBloodType = newValue;
                        });
                      },
                      items:
                          blood.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField<String>(
                      hint: Text('Select City'),
                      value: _currentCity,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (String newValue) {
                        setState(() {
                          _currentCity = newValue;
                        });
                      },
                      items: city.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20.0),
                    // RaisedButton(
                    //   color: Colors.pink[400],
                    //   child:
                    //       Text('Update', style: TextStyle(color: Colors.white)),
                    //   onPressed: () async {
                    //     if (_formKey.currentState.validate()) {
                    //       await DatabaseService(uid: user.uid).updateUserData(
                    //           _currentBloodType ?? userData.bloodType,
                    //           _currentName ?? userData.name,
                    //           _currentCity ?? userData.city,
                    //           _currentPhoneNumber ?? userData.phoneNumber);
                    //       // Navigator.pop(context);
                    //     }
                    //   },
                    // ),
                    SizedBox(height: 30),

                    Text(
                      'Gender :',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: 'Male',
                          groupValue: _currentGender,
                          onChanged: _handleRadioValueChange1,
                        ),
                        Text(
                          'Male',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 'Female',
                          groupValue: _currentGender,
                          onChanged: _handleRadioValueChange1,
                        ),
                        Text(
                          'Female',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        Radio(
                          value: 'Other',
                          groupValue: _currentGender,
                          onChanged: _handleRadioValueChange1,
                        ),
                        Text(
                          'Other',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 18, horizontal: 40),
                          color: Colors.red[700],
                          onPressed: () async {
                            if (_formKey.currentState.validate() &&
                                _currentCity != null &&
                                _currentBloodType != null &&
                                _currentGender != null) {
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                      _currentBloodType ?? userData.bloodType,
                                      _currentName ?? userData.name,
                                      _currentCity ?? userData.city,
                                      _currentPhoneNumber ??
                                          userData.phoneNumber,
                                      _currentGender ?? userData.gender);
                              // Navigator.pop(context);
                            }
                          },
                          child: Text(
                            'Update',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Container(
                    //     child: Text(
                    //       'Profile ',
                    //       style: TextStyle(
                    //         fontSize: 25,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 40.0),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.red[600],
                              child: Text(
                                '${userData.bloodType}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40.0,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          // Text('Congratulations!'),
                          // SizedBox(height: 20.0),
                          // Text('You are registered as Corona Recovered'),
                          SizedBox(height: 20.0),
                          Text(
                            'Name: ${userData.name}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Number: ${userData.phoneNumber}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          // Text(
                          //   'Blood Type: ${userData.bloodType}',
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 20.0,
                          //   ),
                          // ),
                          // SizedBox(height: 20.0),
                          Text(
                            'City: ${userData.city}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 20.0),

                          Text(
                            'Gender: ${userData.gender}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 50.0),
                          // RaisedButton(
                          //   color: Colors.pink[400],
                          //   child: Text('Delete your data',
                          //       style: TextStyle(color: Colors.white)),
                          //   onPressed: () async {
                          //     await DatabaseService(uid: user.uid).deleteUserData();
                          //   },
                          // ),
                          Container(
                            // width: 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(29),
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40),
                                color: Colors.red[700],
                                onPressed: () async {
                                  await DatabaseService(uid: user.uid)
                                      .deleteUserData();
                                },
                                child: Text(
                                  'Delete my data',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

// @override
// Widget build(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Center(
//             child: const Text(
//                 'Are you Corona recovered and want to donate blood?!'),
//           ),
//           Center(
//             child: const Text('Enter your details below'),
//           ),
//           const SizedBox(height: 30),
//           RaisedButton(
//             color: Colors.pink[400],
//             onPressed: widget.askdata,
//             child: const Text(
//               'Press here',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           const SizedBox(height: 30),
//         ],
//       ),
//     ),
//   );
