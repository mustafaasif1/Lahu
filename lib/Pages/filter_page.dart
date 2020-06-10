import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lahu/Models/user.dart';
import 'package:lahu/Services/database.dart';
import 'package:lahu/Models/lahu_data_class.dart';
import 'package:lahu/Models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lahu/Pages/lahu_tile.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
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
  List<LahuDataObject> _result = [];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
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
                    child:
                        Text('Search', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      print(_currentBloodType ?? blood[0]);
                      print(_currentCity ?? city[0]);

                      dynamic resultOtained =
                          await DatabaseService(uid: user.uid)
                              .getResults(_currentBloodType, _currentCity);

                      // print(resultOtained[0].name);

                      setState(() {
                        _result = resultOtained;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _result.length,
                itemBuilder: (context, index) {
                  return LahuTile(lahuObject: _result[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
