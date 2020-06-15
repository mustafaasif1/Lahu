import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lahu/Models/user.dart';
import 'package:lahu/Services/database.dart';
import 'package:intl/intl.dart';

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
    'Sargodha',
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

  String _currentName;
  String _currentPhoneNumber;
  String _currentBloodType;
  String _currentCity;
  String _currentGender;
  String _currentStatus;
  DateTime _recoveryDateTime;

  bool checkedValue = false;
  bool _showcalender = false;
  String _showDate = "Pick a date";
  DateTime now = DateTime.now();

  bool _checkStatus() {
    if (_currentStatus == "Corona Recovered") {
      if (_recoveryDateTime == null) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  void _handleRadioValueChange1(String value) {
    setState(() {
      _currentGender = value;
    });
  }

  void _handleCurrentStatusChange(String value) {
    setState(() {
      _currentStatus = value;
      _currentStatus == "Corona Recovered"
          ? _showcalender = true
          : _currentStatus == "Normal"
              ? _showcalender = false
              : _showcalender = null;
    });
  }

  String _validateMobile(String value) {
    String patttern = r'([0-9]{11}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    city.sort();

    return StreamBuilder<AllDonorData>(
        stream: DatabaseService(uid: user.uid).donorData1,
        builder: (context, snapshot) {
          AllDonorData donorData = snapshot.data;
          if (!snapshot.hasData) {
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
                          'Do you want to donate blood or blood plasma? Enter your details below.',
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
                      validator: _validateMobile,
                      // validator: (val) {
                      //   if (val.isEmpty) {
                      //     return 'Please enter your number';
                      //   } else if (val.length != 11) {
                      //     return 'Please enter correct number';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      onChanged: (val) =>
                          setState(() => _currentPhoneNumber = val),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone),
                        hintText: 'Phone Number',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     "Your number will not be displayed without your consent",
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 15.0,
                    //     ),
                    //   ),
                    // ),
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

                    SizedBox(height: 10),
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
                    Text(
                      'Current Status :',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Radio(
                                value: 'Corona Recovered',
                                groupValue: _currentStatus,
                                onChanged: _handleCurrentStatusChange,
                              ),
                              Text(
                                'Corona Recovered',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: 'Normal',
                                    groupValue: _currentStatus,
                                    onChanged: _handleCurrentStatusChange,
                                  ),
                                  Text(
                                    'Normal',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "When did you recover: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2018),
                                    lastDate: DateTime.now(),
                                  ).then((date) {
                                    setState(() {
                                      _recoveryDateTime = date;
                                      //print(_dateTime.toString());
                                      // print("${_recoveryDateTime.toLocal()}"
                                      //     .split(' ')[0]);
                                      _showDate = DateFormat('dd-MM-yyyy')
                                          .format(_recoveryDateTime);
                                    });
                                  });
                                },
                                child: Text(_showDate,
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      visible: _showcalender,
                    ),

                    CheckboxListTile(
                      title: Text(
                        "I allow people to contact me for requesting blood. I agree that I do not have any disease that restricts me in donating blood or blood plasma. I also agree that I would not be selling my blood.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      value: checkedValue,
                      onChanged: (newValue) {
                        setState(() {
                          checkedValue = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
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
                                _currentGender != null &&
                                checkedValue == true &&
                                _currentStatus != null &&
                                _checkStatus()) {
                              if (_currentStatus == "Normal") {
                                setState(() {
                                  _recoveryDateTime = DateTime.now();
                                });
                              }
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                _currentName,
                                _currentPhoneNumber,
                                _currentBloodType,
                                _currentCity,
                                _currentGender,
                                _currentStatus,
                                _recoveryDateTime,
                                DateTime.now(),
                              );
                              // Navigator.pop(context);

                              // print(_currentName);
                              // print(_currentBloodType);
                              // print(_currentCity);
                              // print(_currentGender);
                              // print(_currentStatus);
                              // print(_recoveryDateTime);

                              // Alert(
                              //   context: context,
                              //   //type: AlertType.error,
                              //   title:
                              //       "Congratuations you have been registered as a blood donor",
                              //   buttons: [
                              //     DialogButton(
                              //       child: Text(
                              //         "Okay",
                              //         style: TextStyle(
                              //             color: Colors.white, fontSize: 20),
                              //       ),
                              //       onPressed: () {
                              //         Navigator.of(context).pop();
                              //       },
                              //       width: 120,
                              //     ),
                              //   ],
                              // ).show();
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

                    Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 30.0),
                            child: Text(
                              'You are currently registered as a donor',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.red[600],
                              child: Text(
                                '${donorData.bloodType}',
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
                            'Name: ${donorData.name}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Number: ${donorData.phoneNumber}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 20.0),

                          Text(
                            'City: ${donorData.city}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 20.0),

                          Text(
                            'Gender: ${donorData.gender}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 20.0),

                          Text(
                            'Status: ${donorData.status}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          if (donorData.status == "Corona Recovered")
                            Column(
                              children: <Widget>[
                                Text(
                                  'Recovery Date: ${DateFormat('dd-MM-yyyy').format(donorData.recoveryDate)}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(height: 20.0),
                              ],
                            ),
                          SizedBox(height: 30.0),
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
