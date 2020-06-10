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
  final List<String> blood = ['A+', 'A-', 'AB', 'B+', 'O-'];
  final List<String> city = [
    'Karachi',
    'Lahore',
    'Islamabad',
    'Multan',
    'Hyderabad'
  ];

  String _currentName;
  String _currentPhoneNumber;
  String _currentBloodType;
  String _currentCity;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

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
                    Center(
                      child: const Text(
                          'Are you Corona recovered and want to donate blood?!'),
                    ),
                    Center(
                      child: const Text('Enter your details below'),
                    ),
                    SizedBox(height: 20.0),
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
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your number' : null,
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
                    RaisedButton(
                      color: Colors.pink[400],
                      child:
                          Text('Update', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentBloodType ?? userData.bloodType,
                              _currentName ?? userData.name,
                              _currentCity ?? userData.city,
                              _currentPhoneNumber ?? userData.phoneNumber);
                          // Navigator.pop(context);
                        }
                      },
                    ),
                  ]),
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('Congratulations!'),
                    SizedBox(height: 20.0),
                    Text('You have already registered as Corona Recovered'),
                    SizedBox(height: 20.0),
                    Text('Name: ${userData.name}'),
                    SizedBox(height: 20.0),
                    Text('Number: ${userData.phoneNumber}'),
                    SizedBox(height: 20.0),
                    Text('Blood Type: ${userData.bloodType}'),
                    SizedBox(height: 20.0),
                    Text('City: ${userData.city}'),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text('Delete your data',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        await DatabaseService(uid: user.uid).deleteUserData();
                      },
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
