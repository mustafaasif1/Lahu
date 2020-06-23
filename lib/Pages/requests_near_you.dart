import 'package:flutter/material.dart';
import 'package:lahu/Models/lahu_data_class.dart';
import 'package:lahu/Models/user.dart';
import 'package:lahu/Pages/lahu_tile.dart';
import 'package:lahu/Services/database.dart';
import 'package:provider/provider.dart';

class RequestsNearYouPage extends StatefulWidget {
  @override
  _RequestsNearYouPageState createState() => _RequestsNearYouPageState();
}

class _RequestsNearYouPageState extends State<RequestsNearYouPage> {
  String _currentCity;
  List<LahuRequestObject> _result = [];

  final List<String> city = [
    'Karachi',
    'Lahore',
    'Faisalabad',
    'Rawalpindi',
    'Gujranwala',
    'Peshawar',
    'Multan',
    'Hyderabad',
    'Islamabad',
    'Quetta',
    'Bahawalpur',
    'Sargodha',
    'Sialkot',
    'Sukkur',
    'Larkana',
    'Sheikhupura',
    'Rahim Yar Khan',
    'Jhang',
    'Dera Ghazi Khan',
    'Gujrat',
    'Sahiwal',
    'Wah Cantonment',
    'Mardan',
    'Kasur',
    'Okara',
    'Mingora',
    'Nawabshah',
    'Chiniot',
    'Kotri',
    'Kamoke',
    'Hafizabad',
    'Sadiqabad',
    'Mirpur Khas',
    'Burewala',
    'Kohat',
    'Khanewal',
    'Dera Ismail Khan',
    'Turbat',
    'Muzaffarabad',
    'Abbotabad',
    'Mandi Bahauddin',
    'Shikarpur',
    'Jacobabad',
    'Jhelum',
    'Khanpur',
    'Khairpur',
    'Khuzdar',
    'Pakpattan',
    'Hub',
    'Daska',
    'Gojra',
    'Dadu',
    'Muridke',
    'Bahawalnagar',
    'Samundri',
    'Tando Allahyar',
    'Tando Adam',
    'Jaram Wala',
    'Chistian',
    'Attock',
    'Vehari',
    'Kot Abdul Malik',
    'Ferozwala',
    'Chaklwal',
    'Gujranwala Cantonment',
    'Kamalia',
    'Umerkot',
    'Ahmedpur East',
    'Kot Addu',
    'Wazirabad',
    'Mansehra',
    'Layyah',
    'Swabi',
    'Chaman',
    'Taxila',
    'Nowshera',
    'Khushab',
    'Shahdakot',
    'Mianwali',
    'Kabal',
    'Lodhran',
    'Hasilpur',
    'Charsadda',
    'Bhakkur',
    'Badin',
    'Arif Wala',
    'Ghokti',
    'Sambrial',
    'Jatoi',
    'Haroonabad',
    'Dharki',
    'Narowal',
    'Tando Muhammad Khan',
    'Kamber Ali Khan',
    'Mirpur Mathelo',
    'Kandhkot',
    'Bhalwal'
  ];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    city.sort();

    return Scaffold(
      appBar: AppBar(title: Text('Requests Near You')),
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
                      'Search For Blood Donation Requests In Your City',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
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
                                    .getDonationCityRequests(_currentCity);

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
                    return LahuTile(lahuObject: _result[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}
