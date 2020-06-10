import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lahu/Models/user.dart';

class FilterForm extends StatefulWidget {
  @override
  _FilterFormState createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  // final _formKey = GlobalKey<FormState>();
  final List<String> blood = ['A+', 'A-', 'AB', 'B+', 'O-', 'All Bloodtypes'];
  final List<String> city = [
    'Karachi',
    'Lahore',
    'Islamabad',
    'Multan',
    'Hyderabad',
    'All Cities'
  ];

  // String _currentName;
  String _currentBloodType;
  String _currentCity;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Column(children: <Widget>[
        DropdownButtonFormField<String>(
          value: _currentBloodType ?? blood[0],
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          onChanged: (String newValue) {
            setState(() {
              _currentBloodType = newValue;
            });
          },
          items: blood.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 20.0),
        DropdownButtonFormField<String>(
          value: _currentCity ?? city[0],
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
          child: Text('Search', style: TextStyle(color: Colors.white)),
          onPressed: () async {
            print(_currentBloodType ?? blood[0]);
            print(_currentCity ?? city[0]);

            // dynamic result = await DatabaseService(uid: user.uid)
            //     .getResults(_currentBloodType, _currentCity);
            // print(result);

            // if (_formKey.currentState.validate()) {
            //   await DatabaseService(uid: user.uid).updateUserData(
            //       _currentBloodType ?? userData.bloodType,
            //       _currentName ?? userData.name,
            //       _currentLocation ?? userData.location);
            //       Navigator.pop(context);
            // }
          },
        ),
      ])),
    );

    // return StreamBuilder<UserData>(
    //     stream: DatabaseService(uid: user.uid).userData,
    //     builder: (context, snapshot) {
    //       // return Loader();
    //       // if (snapshot.hasData) {
    //       //   UserData userData = snapshot.data;

    //       //   return Form(
    //       //     key: _formKey,
    //       //     child: Column(children: <Widget>[
    //       //       Text(
    //       //         ' Update your Settings.',
    //       //         style: TextStyle(fontSize: 18.0),
    //       //       ),
    //       //       SizedBox(height: 20.0),
    //       //       TextFormField(
    //       //         initialValue: userData.name,
    //       //         validator: (val) =>
    //       //             val.isEmpty ? 'Please enter a name' : null,
    //       //         onChanged: (val) => setState(() => _currentName = val),
    //       //       ),
    //       //       SizedBox(height: 20.0),
    //       //       DropdownButtonFormField<String>(
    //       //         value: _currentBloodType ?? userData.bloodType,
    //       //         icon: Icon(Icons.arrow_downward),
    //       //         iconSize: 24,
    //       //         elevation: 16,
    //       //         onChanged: (String newValue) {
    //       //           setState(() {
    //       //             _currentBloodType = newValue;
    //       //           });
    //       //         },
    //       //         items: blood.map<DropdownMenuItem<String>>((String value) {
    //       //           return DropdownMenuItem<String>(
    //       //             value: value,
    //       //             child: Text(value),
    //       //           );
    //       //         }).toList(),
    //       //       ),
    //       //       SizedBox(height: 20.0),
    //       //       DropdownButtonFormField<String>(
    //       //         value: _currentLocation ?? userData.location,
    //       //         icon: Icon(Icons.arrow_downward),
    //       //         iconSize: 24,
    //       //         elevation: 16,
    //       //         onChanged: (String newValue) {
    //       //           setState(() {
    //       //             _currentLocation = newValue;
    //       //           });
    //       //         },
    //       //         items: area.map<DropdownMenuItem<String>>((String value) {
    //       //           return DropdownMenuItem<String>(
    //       //             value: value,
    //       //             child: Text(value),
    //       //           );
    //       //         }).toList(),
    //       //       ),
    //       //       SizedBox(height: 20.0),
    //       //       RaisedButton(
    //       //         color: Colors.pink[400],
    //       //         child: Text('Update', style: TextStyle(color: Colors.white)),
    //       //         onPressed: () async {
    //       //           if (_formKey.currentState.validate()) {
    //       //             await DatabaseService(uid: user.uid).updateUserData(
    //       //                 _currentBloodType ?? userData.bloodType,
    //       //                 _currentName ?? userData.name,
    //       //                 _currentLocation ?? userData.location);
    //       //                 Navigator.pop(context);
    //       //           }
    //       //         },
    //       //       ),
    //       //     ]),
    //       //   );
    //       // } else {
    //       //   return Loader();
    //       // }
    //     });
  }
}
