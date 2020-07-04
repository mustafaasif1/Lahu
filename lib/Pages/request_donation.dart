import 'package:flutter/material.dart';
import 'package:lahu/Helper/constants.dart';
import 'package:lahu/Models/lahu_data_class.dart';
import 'package:provider/provider.dart';
import 'package:lahu/Models/user.dart';
import 'package:lahu/Services/database.dart';
// import 'package:intl/intl.dart';

class RequestDonation extends StatefulWidget {
  @override
  _RequestDonationState createState() => _RequestDonationState();
}

class _RequestDonationState extends State<RequestDonation> {
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
  String _currentDetails;

  String _currentBloodType;
  String _currentCity;
  String _currentStatus;
  String _currentGender;

  String _error = '';

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

  void _handleRadioValueChange1(String value) {
    setState(() {
      _currentGender = value;
    });
  }

  void _handleCurrentStatusChange(String value) {
    setState(() {
      _currentStatus = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<List<LahuRequestObject>>(
        stream: DatabaseService(uid: user.uid).checkLastPost,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Request For Blood Or Blood Plasma',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Please enter a name' : null,
                        onChanged: (val) => setState(() => _currentName = val),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Name of Patient',
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
                      SizedBox(height: 20.0),
                      TextFormField(
                        maxLines: null,
                        validator: (val) =>
                            val.isEmpty ? 'Enter Description' : null,
                        onChanged: (val) =>
                            setState(() => _currentDetails = val),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.description),
                          hintText: 'Enter details',
                        ),
                      ),
                      SizedBox(height: 20.0),
                      DropdownButtonFormField<String>(
                        hint: Text('Select Required Blood Group'),
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
                        items:
                            city.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(height: 20),
                      Text(
                        'Status of blood required :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
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
                                            onChanged:
                                                _handleCurrentStatusChange,
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
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Gender of patient:',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          'Please Note: You can post only once every 15 minutes',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        _error,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
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
                                  _currentStatus != null) {
                                // await DatabaseService(uid: user.uid)
                                //     .updateRequestDonationData(
                                //   _currentName,
                                //   _currentPhoneNumber,
                                //   _currentDetails,
                                //   _currentBloodType,
                                //   _currentCity,
                                //   _currentGender,
                                //   _currentStatus,
                                //   DateTime.now(),
                                //   Constants.myName,
                                //   Constants.myEmail,
                                // );
                                // Navigator.pop(context);

                                if (!snapshot.hasData ||
                                    snapshot.data.isEmpty) {
                                  print("No data");
                                  await DatabaseService(uid: user.uid)
                                      .updateRequestDonationData(
                                    _currentName,
                                    _currentPhoneNumber,
                                    _currentDetails,
                                    _currentBloodType,
                                    _currentCity,
                                    _currentGender,
                                    _currentStatus,
                                    DateTime.now(),
                                    Constants.myName,
                                    Constants.myEmail,
                                  );
                                  Navigator.pop(context);
                                } else {
                                  print(snapshot.data);
                                  print("Yes data");
                                  print(snapshot.data[0].timeStamp);
                                  var thirtyMinutesFromNow = DateTime.now()
                                      .subtract(Duration(minutes: 15));

                                  if (thirtyMinutesFromNow
                                      .isAfter(snapshot.data[0].timeStamp)) {
                                    await DatabaseService(uid: user.uid)
                                        .updateRequestDonationData(
                                      _currentName,
                                      _currentPhoneNumber,
                                      _currentDetails,
                                      _currentBloodType,
                                      _currentCity,
                                      _currentGender,
                                      _currentStatus,
                                      DateTime.now(),
                                      Constants.myName,
                                      Constants.myEmail,
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    DateTime dateTimeCreatedAt =
                                        thirtyMinutesFromNow;

                                    DateTime dateTimeNow =
                                        snapshot.data[0].timeStamp;
                                    final differenceInDays = dateTimeNow
                                        .difference(dateTimeCreatedAt)
                                        .inMinutes;
                                    setState(() {
                                      _error =
                                          'You have recently posted within 15 minutes. Please wait $differenceInDays minutes before trying to post again';
                                    });
                                  }
                                }
                              }
                            },
                            child: Text(
                              'Post',
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
        });
  }
}
