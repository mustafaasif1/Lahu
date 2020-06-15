import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lahu/Models/user.dart';
import 'package:lahu/Services/database.dart';
import 'package:lahu/Models/lahu_data_class.dart';
import 'package:lahu/Pages/filter_tiles.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage>
    with AutomaticKeepAliveClientMixin<FilterPage> {
  // final _formKey = GlobalKey<FormState>();
  final List<String> blood = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
    'All Bloodtypes'
  ];
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
    'Abbotabad',
    'All Cities'
  ];

  final List<String> status = ['Normal', 'Corona Recovered', 'Both'];

  // String _currentName;
  String _currentBloodType;
  String _currentCity;
  // String _currentStatus;
  List<LahuDataObject> _result = [];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    city.sort();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Search For Blood Donors ',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ExpansionTile(
                      title: Text(
                        'Press to expand search ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: <Widget>[
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
                          items: blood
                              .map<DropdownMenuItem<String>>((String value) {
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
                          items: city
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20.0),
                        // DropdownButtonFormField<String>(
                        //   hint: Text('Select Status of Donor'),
                        //   value: _currentStatus,
                        //   icon: Icon(Icons.arrow_downward),
                        //   iconSize: 24,
                        //   elevation: 16,
                        //   onChanged: (String newValue) {
                        //     setState(() {
                        //       _currentStatus = newValue;
                        //     });
                        //   },
                        //   items: status
                        //       .map<DropdownMenuItem<String>>((String value) {
                        //     return DropdownMenuItem<String>(
                        //       value: value,
                        //       child: Text(value),
                        //     );
                        //   }).toList(),
                        // ),
                        // SizedBox(height: 20.0),
                        Container(
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(29),
                            child: FlatButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              color: Colors.red[700],
                              onPressed: () async {
                                // print(_currentBloodType ?? blood[0]);
                                // print(_currentCity ?? city[0]);

                                dynamic resultOtained =
                                    await DatabaseService(uid: user.uid)
                                        .getResults(
                                            _currentBloodType, _currentCity);

                                // print(resultOtained[0].name);

                                setState(() {
                                  _result = resultOtained;
                                });
                              },
                              child: Text(
                                'Search',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),

                    // RaisedButton(
                    //   color: Colors.pink[400],
                    //   child:
                    //       Text('Search', style: TextStyle(color: Colors.white)),
                    //   onPressed: () async {
                    //     // print(_currentBloodType ?? blood[0]);
                    //     // print(_currentCity ?? city[0]);

                    //     dynamic resultOtained =
                    //         await DatabaseService(uid: user.uid)
                    //             .getResults(_currentBloodType, _currentCity);

                    //     // print(resultOtained[0].name);

                    //     setState(() {
                    //       _result = resultOtained;
                    //     });
                    //   },
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _result.length,
                  itemBuilder: (context, index) {
                    return FilterTile(lahuObject: _result[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
